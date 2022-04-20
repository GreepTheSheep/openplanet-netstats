Server@ g_server;
Client@ g_client;
Rendering@ g_rendering;

void Main()
{
    @g_server = Server();
    @g_client = Client();
    @g_rendering = Rendering();
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
    if (SettingsStatusText::showRender) g_rendering.RenderStatusText();
}