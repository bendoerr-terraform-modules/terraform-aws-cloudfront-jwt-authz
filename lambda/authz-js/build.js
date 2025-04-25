const esbuild = require("esbuild");

esbuild
  .build({
    entryPoints: ["index.ts"],
    bundle: true,
    platform: "node",
    target: "node22",
    format: "cjs",
    outfile: "dist/index.cjs",
    define: {
      "process.env.JWT_ISSUER": JSON.stringify(
        process.env.JWT_ISSUER || "invalid",
      ),
      "process.env.JWT_AUDIENCE": JSON.stringify(process.env.JWT_AUDIENCE),
      "process.env.JWT_JWKS_URI": JSON.stringify(
        process.env.JWT_JWKS_URI || "invalid",
      ),
    },
    minify: true,
    sourcemap: true,
    logLevel: "info",
  })
  .catch(() => process.exit(1));
