module.exports = {
  env: {
    es2021: true,
    node: true,
  },
  extends: ["standard-with-typescript", "prettier"],
  overrides: [
    {
      env: {
        node: true,
      },
      files: [".eslintrc.{js,cjs}"],
      parserOptions: {
        sourceType: "script",
      },
    },
  ],
  parserOptions: {
    ecmaVersion: "latest",
    sourceType: "module",
  },
  rules: {
    "@typescript-eslint/no-non-null-assertion": "off",
    "@typescript-eslint/explicit-function-return-type": "off",
  },
};
