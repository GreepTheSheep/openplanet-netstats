Server@ g_server;
Client@ g_client;

Graph@ g_fpsGraph;

void Main()
{
    @g_server = Server();
    @g_client = Client();
    @g_fpsGraph = Graph("FPS");
}

void RenderMenu() {
    if (UI::BeginMenu("\\$ca0" + Icons::LineChart + "\\$z Net Stats"))
    {
        if (UI::MenuItem("Show Text", "", SettingsStatusText::showRender)) {
            SettingsStatusText::showRender = !SettingsStatusText::showRender;
        }
        UI::EndMenu();
    }
}

void Update(float dt)
{
    g_client.Update(dt);
    g_server.checkIsOnServer();
    if (g_server.isOnServer) g_server.Update(dt);
    else g_server.ResetStats();
}

void Render()
{
    if (SettingsStatusText::showRender) RenderStatusText::Render();

    if (SettingsGraphs::showRender) {
        if (SettingsGraphs::showFps) {
            g_fpsGraph.showValueText = SettingsGraphs::displayFpsValue;
            g_fpsGraph.useHostogram = SettingsGraphs::displayFpsHistogram;
            g_fpsGraph.valueTextDecimals = SettingsGraphs::fpsDecimals;
            g_fpsGraph.Render(g_client.Framerate);
        }
    }
}

void RenderInterface()
{
    if (SettingsStatusText::locatorMode) {
        Locator::Render("Status text", SettingsStatusText::position, SettingsStatusText::stringSize);
        SettingsStatusText::position = Locator::GetPos();
		SettingsStatusText::stringSize = Locator::GetSize();
    }
}