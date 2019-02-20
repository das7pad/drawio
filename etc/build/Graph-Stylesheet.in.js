Graph.prototype.defaultThemes[
	Graph.prototype.defaultThemeName
	] = mxUtils.parseXml('%default%').documentElement;
Graph.prototype.defaultThemes[
	'darkTheme'
	] = mxUtils.parseXml('%dark-default%').documentElement;
