function reflectivity = solution(filename, lambda)

	data = dlmread(filename);	% read in data from CXRO file
	data = data(3:end,1:3); % select only columns which have data

	x = data(:,1); % The wavelength will be the independent variable
	y = data(:, 2); % The reflectivity will be the dependent variable
	
	spl = interp1(x, y, lambda, "spline");	% perform the interpolation
		
	a = lt(spl, 0);	% determine which elements of the interpolation are less than zero
	b = find(a);	% create an array of indices of negative reflectivity
	spl(b) = 0;		% set negative elements equal to zero
	
	c = gt(spl, 1); % determine which elements are greater than one
	d = find(c);	% find indices of impossible reflectivity
	spl(d) = 1;		% Set large elements equal to one.
	
	plot(x, y, '+', lambda, spl, '-')	% plot the data and the interpolation
	legend('CXRO data', 'Interpolated Reflectivity')
	title('Reflectivity of Multilayer vs. Wavelength')
	
	reflectivity = spl;	% return the finished range
	
	
end
