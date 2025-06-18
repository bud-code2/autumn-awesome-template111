import { render, screen, fireEvent } from '@testing-library/react';

import Home from './page';
import '@testing-library/jest-dom';

describe('Home Page', () => {
	it('renders initial count of 0', () => {
		render(<Home />);
		expect(screen.getByText('0')).toBeInTheDocument();
	});

	it('increments count when button is clicked', () => {
		render(<Home />);
		const button = screen.getByText('Increment');

		// Initial count should be 0
		expect(screen.getByText('0')).toBeInTheDocument();

		// Click the button
		fireEvent.click(button);

		// Count should be 1
		expect(screen.getByText('1')).toBeInTheDocument();

		// Click again
		fireEvent.click(button);

		// Count should be 2
		expect(screen.getByText('2')).toBeInTheDocument();
	});
});
