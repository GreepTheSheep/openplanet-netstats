namespace SettingsStatusText
{
    [Setting name="Show Status Text" category="Status Text"]
    bool showRenderText = true;

    enum textAlign { Left = 1, Center = 2, Right = 4 }
    [Setting name="Text Alignment" category="Status Text"]
    textAlign textAlignText = textAlign::Center;

    [Setting name="Locator Mode" category="Status Text"]
    bool locatorModeText = false;

    [Setting name="Position" category="Status Text"]
    vec2 positionText = vec2(.5, .02);

    [Setting hidden]
    vec2 stringSizeText = vec2(0, 0);

    [Setting name="Font size" min=8 max=72 category="Status Text"]
    int fontSizeText = 18;

    [Setting color name="Font color" category="Status Text"]
    vec4 fontColorText = vec4(1, 1, 1, 1);

    [Setting name="Shadow" category="Status Text"]
    bool shadowText = true;

    [Setting name="Separator" category="Status Text"]
    string SeparatorText = "|";

    [Setting name="Show Framerate" category="Status Text"]
    bool showFpsText = true;

    [Setting name="Framerate decimals" category="Status Text"]
    int fpsDecimalsText = 0;

    [Setting name="Show Ping" category="Status Text"]
    bool showPingText = true;

    [Setting name="Show Packet Loss Rate" category="Status Text"]
    bool showPacketLossText = true;

    [Setting name="Packet Loss Rate decimals" category="Status Text"]
    int packetLossDecimalsText = 0;

    [Setting name="Show Download Rate" category="Status Text"]
    bool showDownloadRateText = false;

    [Setting name="Show Upload Rate" category="Status Text"]
    bool showUploadRateText = false;

    enum rateUnit { Bytes, KB, MB }
    [Setting name="Rate Unit (per second)" category="Status Text"]
    rateUnit rateUnitText = rateUnit::KB;
}
