module.exports = {
  extends: ["@commitlint/config-conventional"],
  rules: {
    "type-enum": [
      2,
      "always",
      [
        "[Add]", // Adding new features
        "[Fix]", // Fixing bugs
        "[Update]", // Updating or Improving feature
        "[Remove]", // Removing features or code
        "[Refactor]", // Code refactoring
        "[Docs]", // Documentation changhes
        "[Test]", // Changes related to tests
        "[Chore]", // Miscellaneous tasks
      ],
    ],
    "type-case": [2, "always", "pascal-case"],
    "scope-enum": [0], // level: disabled
  },
};
