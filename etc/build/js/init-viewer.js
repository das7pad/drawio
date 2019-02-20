(function()
{
	Editor.initMath();
	GraphViewer.initCss();

	if (window.onDrawioViewerLoad != null)
	{
		window.onDrawioViewerLoad();
	}
	else
	{
		GraphViewer.processElements();
	}
})();
