namespace SettingsStatusText
{
    [Setting name="Show Status Text" category="Status Text"]
    bool showRender = true;

    enum TextAlign { Left = 1, Center = 2, Right = 4 }
    [Setting name="Text Alignment" category="Status Text"]
    TextAlign textAlign = TextAlign::Right;

    [Setting name="Locator Mode" category="Status Text"]
    bool locatorMode = false;

    [Setting name="Position" category="Status Text"]
    vec2 position = vec2(1, .01);

    [Setting hidden]
    vec2 stringSize = vec2(0, 0);

    [Setting name="Font size" min=8 max=72 category="Status Text"]
    int fontSize = 18;

    [Setting color name="Font color" category="Status Text"]
    vec4 fontColor = vec4(1, 1, 1, 1);

    [Setting name="Shadow" category="Status Text"]
    bool shadow = true;

    [Setting name="Separator" category="Status Text"]
    string Separator = "|";

    [Setting name="Show Framerate" category="Status Text"]
    bool showFps = true;

    [Setting name="Framerate decimals" category="Status Text"]
    int fpsDecimals = 0;

    [Setting name="Show Ping" category="Status Text"]
    bool showPing = true;

    [Setting name="Show Packet Loss Rate" category="Status Text"]
    bool showPacketLoss = true;

    [Setting name="Packet Loss Rate decimals" category="Status Text"]
    int packetLossDecimals = 0;

    [Setting name="Show Download Rate" category="Status Text"]
    bool showDownloadRate = false;

    [Setting name="Show Upload Rate" category="Status Text"]
    bool showUploadRate = false;

    enum RateUnit { Bytes, KB, MB }
    [Setting name="Rate Unit (per second)" category="Status Text"]
    RateUnit rateUnit = RateUnit::KB;
}
