namespace SettingsGraphs
{
    [Setting name="Show All Graphs" category="Graphs" description="To move/resize graphs, the Openplanet overlay must be shown"]
    bool showRender = true;

    [Setting name="Show Framerate" category="Graphs"]
    bool showFps = true;

    [Setting name="FPS: Display Value" category="Graphs"]
    bool displayFpsValue = true;

    [Setting name="FPS: Value decimals" category="Graphs"]
    int fpsDecimals = 0;

    [Setting name="FPS: Display histogram instead of line" category="Graphs"]
    bool displayFpsHistogram = false;
}