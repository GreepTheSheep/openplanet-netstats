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
            if (UI::MenuItem("Show Text", "", SettingsStatusText::showRenderText))
                SettingsStatusText::showRenderText = !SettingsStatusText::showRenderText;
            UI::Separator();
            if (UI::MenuItem("FPS", "", SettingsStatusText::showFpsText))
                SettingsStatusText::showFpsText = !SettingsStatusText::showFpsText;
            if (UI::MenuItem("Ping", "", SettingsStatusText::showPingText))
                SettingsStatusText::showPingText = !SettingsStatusText::showPingText;
            if (UI::MenuItem("Packet Loss", "", SettingsStatusText::showPacketLossText))
                SettingsStatusText::showPacketLossText = !SettingsStatusText::showPacketLossText;
            if (UI::MenuItem("Download Rate", "", SettingsStatusText::showDownloadRateText))
                SettingsStatusText::showDownloadRateText = !SettingsStatusText::showDownloadRateText;
            if (UI::MenuItem("Upload Rate", "", SettingsStatusText::showUploadRateText))
                SettingsStatusText::showUploadRateText = !SettingsStatusText::showUploadRateText;
            UI::EndMenu();
        }
        if (UI::BeginMenu("Graphs"))
        {
            if (UI::MenuItem("Show Graphs", "", SettingsGraphs::showRenderGraphs))
                SettingsGraphs::showRenderGraphs = !SettingsGraphs::showRenderGraphs;
            UI::Separator();
            if (UI::MenuItem("FPS", "", SettingsGraphs::showFpsGraph))
                SettingsGraphs::showFpsGraph = !SettingsGraphs::showFpsGraph;
            if (UI::MenuItem("Ping", "", SettingsGraphs::showPingGraph))
                SettingsGraphs::showPingGraph = !SettingsGraphs::showPingGraph;
            if (UI::MenuItem("Packet Loss", "", SettingsGraphs::showPacketLossGraph))
                SettingsGraphs::showPacketLossGraph = !SettingsGraphs::showPacketLossGraph;
            if (UI::MenuItem("Download Rate", "", SettingsGraphs::showDownloadRateGraph))
                SettingsGraphs::showDownloadRateGraph = !SettingsGraphs::showDownloadRateGraph;
            if (UI::MenuItem("Upload Rate", "", SettingsGraphs::showUploadRateGraph))
                SettingsGraphs::showUploadRateGraph = !SettingsGraphs::showUploadRateGraph;
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
    if (SettingsStatusText::showRenderText) RenderStatusText::Render();

    if (SettingsGraphs::showRenderGraphs) {
        if (SettingsGraphs::showFpsGraph) {
            g_fpsGraph.showValueText = SettingsGraphs::displayFpsValueGraph;
            g_fpsGraph.useHistogram = SettingsGraphs::displayFpsHistogramGraph;
            g_fpsGraph.valueTextDecimals = SettingsGraphs::fpsDecimalsGraph;
            g_fpsGraph.color = SettingsGraphs::displayFpsColorGraph;
            g_fpsGraph.backgroundAlpha = SettingsGraphs::displayFpsAlphaGraph;
            g_fpsGraph.Render(g_client.Framerate);
        }

        if (g_server.isOnServer) {
            if (SettingsGraphs::showPingGraph) {
                g_pingGraph.showValueText = SettingsGraphs::displayPingValueGraph;
                g_pingGraph.useHistogram = SettingsGraphs::displayPingHistogramGraph;
                g_pingGraph.valueTextDecimals = 0;
                g_pingGraph.color = SettingsGraphs::displayPingColorGraph;
                g_pingGraph.backgroundAlpha = SettingsGraphs::displayPingAlphaGraph;
                g_pingGraph.Render(g_server.Ping);
            }

            if (SettingsGraphs::showPacketLossGraph) {
                g_packetLossGraph.showValueText = SettingsGraphs::displayPacketLossValueGraph;
                g_packetLossGraph.useHistogram = SettingsGraphs::displayPacketLossHistogramGraph;
                g_packetLossGraph.valueTextDecimals = 0;
                g_packetLossGraph.color = SettingsGraphs::displayPacketLossColorGraph;
                g_packetLossGraph.backgroundAlpha = SettingsGraphs::displayPacketLossAlphaGraph;
                g_packetLossGraph.Render(g_server.PacketLossRate);
            }

            if (SettingsGraphs::showDownloadRateGraph) {
                uint downloadRate = g_server.TotalRecvSize;
                g_DLGraph.showValueText = SettingsGraphs::displayDLValueGraph;
                g_DLGraph.useHistogram = SettingsGraphs::displayDLHistogramGraph;
                g_DLGraph.valueTextDecimals = 0;
                g_DLGraph.color = SettingsGraphs::displayDLColorGraph;
                g_DLGraph.backgroundAlpha = SettingsGraphs::displayDLAlphaGraph;
                g_DLGraph.measure = SettingsGraphs::displayDLRateUnitGraph+"/s";
                if (SettingsGraphs::displayDLRateUnitGraph == "KB") downloadRate = downloadRate / 1024;
                else if (SettingsGraphs::displayDLRateUnitGraph == "MB") downloadRate = downloadRate / (1024*1024);
                g_DLGraph.Render(downloadRate);
            }

            if (SettingsGraphs::showUploadRateGraph) {
                uint uploadRate = g_server.TotalSendSize;
                g_ULGraph.showValueText = SettingsGraphs::displayULValueGraph;
                g_ULGraph.useHistogram = SettingsGraphs::displayULHistogramGraph;
                g_ULGraph.valueTextDecimals = 0;
                g_ULGraph.color = SettingsGraphs::displayULColorGraph;
                g_ULGraph.backgroundAlpha = SettingsGraphs::displayULAlphaGraph;
                g_ULGraph.measure = SettingsGraphs::displayULRateUnitGraph+"/s";
                if (SettingsGraphs::displayULRateUnitGraph == "KB") uploadRate = uploadRate / 1024;
                else if (SettingsGraphs::displayULRateUnitGraph == "MB") uploadRate = uploadRate / (1024*1024);
                g_ULGraph.Render(uploadRate);
            }
        }
    }
}

void RenderInterface()
{
    if (SettingsStatusText::locatorModeText) {
        Locator::Render("Status text", SettingsStatusText::positionText, SettingsStatusText::stringSizeText);
        SettingsStatusText::positionText = Locator::GetPos();
		SettingsStatusText::stringSizeText = Locator::GetSize();
    }
}