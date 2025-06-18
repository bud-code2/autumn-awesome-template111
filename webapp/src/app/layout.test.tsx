import { render } from '@testing-library/react';

import RootLayout from './layout';
import '@testing-library/jest-dom';

// Mock next/font/google
jest.mock('next/font/google', () => ({
	Geist: () => ({
		variable: '--font-geist-sans',
		subsets: ['latin'],
	}),
	Geist_Mono: () => ({
		variable: '--font-geist-mono',
		subsets: ['latin'],
	}),
}));

// Note: We cannot test <html> or <body> tags or their classes in JSDOM/test environment.
// We can only verify that children are rendered.
describe('RootLayout', () => {
	it('renders children correctly', () => {
		const { getByText } = render(
			<RootLayout>
				<div data-testid='test-child'>Test Content</div>
			</RootLayout>,
		);
		expect(getByText('Test Content')).toBeInTheDocument();
	});
});
