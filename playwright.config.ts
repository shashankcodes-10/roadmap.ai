import { defineConfig } from "@playwright/test";

export default defineConfig({
  testDir: "./e2e",
  fullyParallel: true,

  webServer: {
    command: "npm run dev",
    url: "http://localhost:3000",
    reuseExistingServer: !process.env.CI,
    env: {
      SQLITE_PATH: "sqlite.e2e.db",
      AUTH_SECRET: "e2e-test-secret",  //dummy token for testing only
    },
  },

  use: {
    baseURL: "http://localhost:3000",
  },
});