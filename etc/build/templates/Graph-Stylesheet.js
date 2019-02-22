Graph.prototype.defaultThemes[
	Graph.prototype.defaultThemeName
	] = mxUtils.parseXml(
		'@DEFAULT@'
).documentElement;

Graph.prototype.defaultThemes[
	'darkTheme'
	] = mxUtils.parseXml(
		'@DARK_DEFAULT@'
).documentElement;
