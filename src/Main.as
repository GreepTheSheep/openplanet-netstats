Server@ g_server;
Client@ g_client;

Graph@ g_fpsGraph;
Graph@ g_pingGraph;
Graph@ g_packetLossGraph;
Graph@ g_DLGraph;
Graph@ g_ULGraph;

void Main()
{
    @g_server = Server();
    @g_client = Client();
    @g_fpsGraph = Graph("FPS");
    g_fpsGraph.defaultPos = vec2(Draw::GetWidth() - 350, 50);
    @g_pingGraph = Graph("Ping", "ms");
    g_pingGraph.defaultPos = vec2(Draw::GetWidth() - 350, 140);
    @g_packetLossGraph = Graph("Packet Loss", "%");
    g_packetLossGraph.defaultPos = vec2(Draw::GetWidth() - 350, 230);
    @g_DLGraph = Graph("Download Rate");
    g_DLGraph.defaultPos = vec2(Draw::GetWidth() - 350, 320);
    @g_ULGraph = Graph("Upload Rate");
    g_ULGraph.defaultPos = vec2(Draw::GetWidth() - 350, 410);
}

void RenderMenu() {
    if (UI::BeginMenu("\\$ca0" + Icons::LineChart + "\\$z Net Stats"))
    {
        if (UI::BeginMenu("Text"))
        {
            if (UI::MenuItem("Show Text", "", SettingsStatusText::showRender))
                SettingsStatusText::showRender = !SettingsStatusText::showRender;
            UI::Separator();
            if (UI::MenuItem("FPS", "", SettingsStatusText::showFps))
                SettingsStatusText::showFps = !SettingsStatusText::showFps;
            if (UI::MenuItem("Ping", "", SettingsStatusText::showPing))
                SettingsStatusText::showPing = !SettingsStatusText::showPing;
            if (UI::MenuItem("Packet Loss", "", SettingsStatusText::showPacketLoss))
                SettingsStatusText::showPacketLoss = !SettingsStatusText::showPacketLoss;
            if (UI::MenuItem("Download Rate", "", SettingsStatusText::showDownloadRate))
                SettingsStatusText::showDownloadRate = !SettingsStatusText::showDownloadRate;
            if (UI::MenuItem("Upload Rate", "", SettingsStatusText::showUploadRate))
                SettingsStatusText::showUploadRate = !SettingsStatusText::showUploadRate;
            UI::EndMenu();
        }
        if (UI::BeginMenu("Graphs"))
        {
            if (UI::MenuItem("Show Graphs", "", SettingsGraphs::showRender))
                SettingsGraphs::showRender = !SettingsGraphs::showRender;
            UI::Separator();
            if (UI::MenuItem("FPS", "", SettingsGraphs::showFps))
                SettingsGraphs::showFps = !SettingsGraphs::showFps;
            if (UI::MenuItem("Ping", "", SettingsGraphs::showPing))
                SettingsGraphs::showPing = !SettingsGraphs::showPing;
            if (UI::MenuItem("Packet Loss", "", SettingsGraphs::showPacketLoss))
                SettingsGraphs::showPacketLoss = !SettingsGraphs::showPacketLoss;
            if (UI::MenuItem("Download Rate", "", SettingsGraphs::showDownloadRate))
                SettingsGraphs::showDownloadRate = !SettingsGraphs::showDownloadRate;
            if (UI::MenuItem("Upload Rate", "", SettingsGraphs::showUploadRate))
                SettingsGraphs::showUploadRate = !SettingsGraphs::showUploadRate;
            UI::EndMenu();
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
            g_fpsGraph.useHistogram = SettingsGraphs::displayFpsHistogram;
            g_fpsGraph.valueTextDecimals = SettingsGraphs::fpsDecimals;
            g_fpsGraph.color = SettingsGraphs::displayFpsColor;
            g_fpsGraph.backgroundAlpha = SettingsGraphs::displayFpsAlpha;
            g_fpsGraph.Render(g_client.Framerate);
        }

        if (g_server.isOnServer) {
            if (SettingsGraphs::showPing) {
                g_pingGraph.showValueText = SettingsGraphs::displayPingValue;
                g_pingGraph.useHistogram = SettingsGraphs::displayPingHistogram;
                g_pingGraph.valueTextDecimals = 0;
                g_pingGraph.color = SettingsGraphs::displayPingColor;
                g_pingGraph.backgroundAlpha = SettingsGraphs::displayPingAlpha;
                g_pingGraph.Render(g_server.Ping);
            }

            if (SettingsGraphs::showPacketLoss) {
                g_packetLossGraph.showValueText = SettingsGraphs::displayPacketLossValue;
                g_packetLossGraph.useHistogram = SettingsGraphs::displayPacketLossHistogram;
                g_packetLossGraph.valueTextDecimals = 0;
                g_packetLossGraph.color = SettingsGraphs::displayPacketLossColor;
                g_packetLossGraph.backgroundAlpha = SettingsGraphs::displayPacketLossAlpha;
                g_packetLossGraph.Render(g_server.PacketLossRate);
            }

            if (SettingsGraphs::showDownloadRate) {
                uint downloadRate = g_server.TotalRecvSize;
                g_DLGraph.showValueText = SettingsGraphs::displayDLValue;
                g_DLGraph.useHistogram = SettingsGraphs::displayDLHistogram;
                g_DLGraph.valueTextDecimals = 0;
                g_DLGraph.color = SettingsGraphs::displayDLColor;
                g_DLGraph.backgroundAlpha = SettingsGraphs::displayDLAlpha;
                g_DLGraph.measure = SettingsGraphs::displayDLRateUnit+"/s";
                if (SettingsGraphs::displayDLRateUnit == "KB") downloadRate = downloadRate / 1024;
                else if (SettingsGraphs::displayDLRateUnit == "MB") downloadRate = downloadRate / (1024*1024);
                g_DLGraph.Render(downloadRate);
            }

            if (SettingsGraphs::showUploadRate) {
                uint uploadRate = g_server.TotalSendSize;
                g_ULGraph.showValueText = SettingsGraphs::displayULValue;
                g_ULGraph.useHistogram = SettingsGraphs::displayULHistogram;
                g_ULGraph.valueTextDecimals = 0;
                g_ULGraph.color = SettingsGraphs::displayULColor;
                g_ULGraph.backgroundAlpha = SettingsGraphs::displayULAlpha;
                g_ULGraph.measure = SettingsGraphs::displayULRateUnit+"/s";
                if (SettingsGraphs::displayULRateUnit == "KB") uploadRate = uploadRate / 1024;
                else if (SettingsGraphs::displayULRateUnit == "MB") uploadRate = uploadRate / (1024*1024);
                g_ULGraph.Render(uploadRate);
            }
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