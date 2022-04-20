Server@ g_server;
Client@ g_client;

void Main()
{
    @g_server = Server();
    @g_client = Client();
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
}

void RenderInterface()
{
    if (SettingsStatusText::locatorMode) {
        Locator::Render("Status text", SettingsStatusText::position, SettingsStatusText::stringSize);
        SettingsStatusText::position = Locator::GetPos();
		SettingsStatusText::stringSize = Locator::GetSize();
    }
}