class Rendering
{

    float cachedHeight;

    Rendering()
    {
        this.UpdateCachedHeight();
    }

    void UpdateCachedHeight()
    {
        cachedHeight = SettingsStatusText::anchorY;
    }

    float GetWidth()
    {
        return SettingsStatusText::anchorX * Draw::GetWidth() - 100;
    }

    float GetHeight()
    {
        return SettingsStatusText::anchorY * Draw::GetHeight();
    }

    void RenderStatusText()
    {
        nvg::FontSize(SettingsStatusText::fontSize);
        nvg::TextAlign(SettingsStatusText::textAlign | nvg::Align::Middle);
        array<string> texts;
        if (SettingsStatusText::showFps) texts.InsertLast(Text::Format("%."+tostring(SettingsStatusText::fpsDecimals)+"f", g_client.Framerate) + " FPS");
        if (g_server.isOnServer) {
            if (SettingsStatusText::showPing) texts.InsertLast("Ping: " + tostring(g_server.Ping) + "ms");
            if (SettingsStatusText::showPacketLoss) texts.InsertLast("Packet Loss: " + Text::Format("%."+tostring(SettingsStatusText::packetLossDecimals)+"f", g_server.PacketLossRate) + "%");
            if (SettingsStatusText::showDownloadRate) {
                uint downloadRate = g_server.TotalRecvSize;
                switch (SettingsStatusText::rateUnit) {
                    case SettingsStatusText::RateUnit::KB:
                        downloadRate = downloadRate / 1024;
                        break;
                    case SettingsStatusText::RateUnit::MB:
                        downloadRate = downloadRate / (1024*1024);
                        break;
                }
                texts.InsertLast("DL Rate: " + tostring(downloadRate) + " " + tostring(SettingsStatusText::rateUnit)+"/s");
            }
            if (SettingsStatusText::showUploadRate) {
                uint uploadRate = g_server.TotalSendSize;
                switch (SettingsStatusText::rateUnit) {
                    case SettingsStatusText::RateUnit::KB:
                        uploadRate = uploadRate / 1024;
                        break;
                    case SettingsStatusText::RateUnit::MB:
                        uploadRate = uploadRate / (1024*1024);
                        break;
                }
                texts.InsertLast("UL Rate: " + tostring(uploadRate) + " " + tostring(SettingsStatusText::rateUnit)+"/s");
            }
        }

        string text = string::Join(texts, " "+SettingsStatusText::Separator+" ");

        nvg::FillColor(SettingsStatusText::fontColor);
        nvg::Text(GetWidth(), GetHeight(), text);

        if (SettingsStatusText::shadow) {
            nvg::FillColor(vec4(0, 0, 0, 0.7));
            nvg::FontBlur(1);
            nvg::Text(GetWidth()+2.8, GetHeight()+2.8, text);
        }
    }
}