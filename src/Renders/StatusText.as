namespace RenderStatusText
{

    float GetWidth() {return SettingsStatusText::positionText.x * Draw::GetWidth();}

    float GetHeight() {return SettingsStatusText::positionText.y * Draw::GetHeight();}

    void Render()
    {
        nvg::FontSize(SettingsStatusText::fontSizeText);
        nvg::TextAlign(SettingsStatusText::textAlignText | nvg::Align::Middle);
        array<string> texts;
        if (SettingsStatusText::showFpsText) texts.InsertLast(Text::Format("%."+tostring(SettingsStatusText::fpsDecimalsText)+"f", g_client.Framerate) + " FPS");
        if (g_server.isOnServer) {
            if (SettingsStatusText::showPingText) texts.InsertLast("Ping: " + tostring(g_server.Ping) + "ms");
            if (SettingsStatusText::showPacketLossText) texts.InsertLast("Packet Loss: " + Text::Format("%."+tostring(SettingsStatusText::packetLossDecimalsText)+"f", g_server.PacketLossRate) + "%");
            if (SettingsStatusText::showDownloadRateText) {
                uint downloadRate = g_server.TotalRecvSize;
                switch (SettingsStatusText::rateUnitText) {
                    case SettingsStatusText::rateUnit::KB:
                        downloadRate = downloadRate / 1024;
                        break;
                    case SettingsStatusText::rateUnit::MB:
                        downloadRate = downloadRate / (1024*1024);
                        break;
                }
                texts.InsertLast("DL Rate: " + tostring(downloadRate) + " " + tostring(SettingsStatusText::rateUnitText)+"/s");
            }
            if (SettingsStatusText::showUploadRateText) {
                uint uploadRate = g_server.TotalSendSize;
                switch (SettingsStatusText::rateUnitText) {
                    case SettingsStatusText::rateUnit::KB:
                        uploadRate = uploadRate / 1024;
                        break;
                    case SettingsStatusText::rateUnit::MB:
                        uploadRate = uploadRate / (1024*1024);
                        break;
                }
                texts.InsertLast("UL Rate: " + tostring(uploadRate) + " " + tostring(SettingsStatusText::rateUnitText)+"/s");
            }
        }

        string text = string::Join(texts, " "+SettingsStatusText::SeparatorText+" ");

        nvg::FillColor(SettingsStatusText::fontColorText);
        nvg::Text(GetWidth(), GetHeight(), text);

        if (SettingsStatusText::shadowText) {
            nvg::FillColor(vec4(0, 0, 0, 0.7));
            nvg::FontBlur(1);
            nvg::Text(GetWidth()+2.8, GetHeight()+2.8, text);
        }
    }
}