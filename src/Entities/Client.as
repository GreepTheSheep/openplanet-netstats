class Client
{
    float Framerate;

    bool isGameHeaderBarShowed;
    bool isOpenplanetBarShowed;

    CHmsViewport@ Viewport;
    CGameSystemOverlay@ SystemOverlay;

    Client()
    {
        @Viewport = cast<CHmsViewport>(GetApp().Viewport);
        @SystemOverlay = cast<CGameSystemOverlay>(GetApp().SystemOverlay);
    }

    void Update(float dt)
    {
        if (Viewport !is null) Framerate = Viewport.AverageFps;
        if (SystemOverlay !is null) isGameHeaderBarShowed = SystemOverlay.ToolBarIsActive;
        isOpenplanetBarShowed = UI::IsOverlayShown();
    }
}