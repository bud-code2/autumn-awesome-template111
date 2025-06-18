/** @jest-config-loader ts-node */

import nextJest from 'next/jest.js';

import type { Config } from 'jest';

const createJestConfig = nextJest({
	// Provide the path to your Next.js app to load next.config.js and .env files in your test environment
	dir: './',
});
const serverTestConfig = {
	displayName: 'server',
	preset: 'ts-jest',
	testEnvironment: 'node',
	testMatch: [
		'<rootDir>/src/**/*.(test).{ts,js}',
		'<rootDir>/src/**/?(*.)(spec|test).{js,ts}',
		'<rootDir>/tests/**/*.(test).{ts,js}',
		'<rootDir>/tests/**/?(*.)(spec|test).{js,ts}',
	],
	moduleNameMapper: {
		'@/(.*)': '<rootDir>/src/$1',
	},
};

const clientTestConfig = {
	displayName: 'client',
	preset: 'ts-jest',
	testEnvironment: 'jest-environment-jsdom',
	testMatch: [
		'<rootDir>/src/**/*.(test).{tsx,jsx}',
		'<rootDir>/src/**/?(*.)(spec|test).{tsx,jsx}',
		'<rootDir>/tests/**/*.(test).{tsx,jsx}',
		'<rootDir>/tests/**/?(*.)(spec|test).{tsx,jsx}',
	],
	moduleNameMapper: {
		'@/(.*)': '<rootDir>/src/$1',
	},
};

const generateConfig = async (): Promise<Config> => {
	// Add any custom config to be passed to Jest
	/** @type {import('jest').Config} */
	const config: Config = {
		// Add more setup options before each test is run
		projects: [await createJestConfig(clientTestConfig)(), await createJestConfig(serverTestConfig)()],
		testPathIgnorePatterns: [
			'/node_modules/',
			'.open-next/',
			'.next/',
			'dist/',
			'provision/',
			'coverage/',
			'.github/',
		],
		collectCoverageFrom: [
			'src/**/*.{ts,tsx}',
			'tests/**/*.{ts,tsx}',
			'!tests/**/*.{spec,test}.{ts,tsx}',
			'!src/**/*.{spec,test}.{ts,tsx}',
			// ignore coverage for ui components
			'!**/components/**/*.ui.*',
		],
		coveragePathIgnorePatterns: [
			'node_modules',
			'dist',
			'provision',
			'coverage',
			'.github',
			'.husky',
			'.next',
			'.open-next',
		],
		collectCoverage: true,
		coverageDirectory: './coverage',
		coverageReporters: ['json', 'lcov', 'text'],
		coverageThreshold: {
			global: {
				lines: 85,
				statements: 85,
			},
		},
	};
	return config;
};

export default generateConfig;
