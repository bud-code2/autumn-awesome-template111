import { dirname } from "path";
import { fileURLToPath } from "url";

import { FlatCompat } from "@eslint/eslintrc";
import js from '@eslint/js'

const __filename = fileURLToPath(import.meta.url);
const __dirname = dirname(__filename);

const compat = new FlatCompat({
  baseDirectory: __dirname,
  recommendedConfig: js.configs.recommended
});

const eslintConfig = [
  ...compat.config({
    extends: [
      'eslint:recommended',
      'plugin:import/recommended',
      'plugin:import/typescript',
      'plugin:react/recommended',
      'plugin:react-hooks/recommended',
      'plugin:jest/recommended',
      'prettier',
      'next',
      'next/core-web-vitals',
      'next/typescript',
    ],
    ignorePatterns: [
      "node_modules/",
      ".next/",
      ".open-next/",
      "provision/",
      ".husky",
      ".commitlintrc.js",
      ".lintstagedrc.js",
      "jest.config.js",
      "open-next.config.ts",
      "next.config.ts",
      "scripts/",
      "coverage/"
    ],
    settings: {
      "import/resolver": {
        "typescript": true,
        "node": true,
      },
    },
    rules: {
      "import/order": ["error", {
        "groups":
          [
            "builtin",
            "external",
            "internal",
            "parent",
            "sibling",
            "index",
            "object",
            "type"
          ],
        "newlines-between": "always"
      }]
    }
  }),
];

export default eslintConfig;
