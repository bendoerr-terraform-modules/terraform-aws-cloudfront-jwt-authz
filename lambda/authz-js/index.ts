import {
  CloudFrontRequestEvent,
  CloudFrontRequestHandler,
  CloudFrontResultResponse,
} from "aws-lambda";
import { JwtVerifier } from "aws-jwt-verify";

const JWT_ISSUER = process.env.JWT_ISSUER;
const JWT_AUDIENCE = process.env.JWT_AUDIENCE;
const JWT_JWKS_URI = process.env.JWT_JWKS_URI;

if (!JWT_ISSUER || !JWT_JWKS_URI) {
  throw new Error("Missing environment variables");
}

// Set up a generic JWT verifier
const verifier = JwtVerifier.create({
  issuer: JWT_ISSUER,
  audience: JWT_AUDIENCE !== "" ? JWT_AUDIENCE : null,
  jwksUri: JWT_JWKS_URI,
});

const unauthorized = (message: string): CloudFrontResultResponse => ({
  status: "401",
  statusDescription: "Unauthorized",
  headers: {
    "content-type": [{ key: "Content-Type", value: "application/json" }],
    "cache-control": [{ key: "Cache-Control", value: "no-store" }],
  },
  body: JSON.stringify({ message }),
});

export const handler: CloudFrontRequestHandler = async (
  event: CloudFrontRequestEvent,
) => {
  const request = event.Records[0].cf.request;
  const headers = request.headers;

  const authHeader = headers["authorization"]?.[0]?.value;

  if (!authHeader || !authHeader.startsWith("Bearer ")) {
    return unauthorized("Missing or malformed Authorization header");
  }

  const token = authHeader.substring(7); // Remove 'Bearer ' prefix

  try {
    await verifier.verify(token);
    console.log("JWT verification successful");
    return request;
  } catch (err) {
    if (err.name) {
      console.error(`JWT verification failed: ${err.name}`, err);
      if (err.name === 'TokenExpiredError') {
        return unauthorized('Token has expired');
      } else if (err.name === 'JsonWebTokenError') {
        return unauthorized('Invalid token');
      }
    } else {
      console.error("JWT verification failed:", err);
    }
    return unauthorized('Authentication failed');
  }
};
