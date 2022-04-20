class Server
{
    CTrackManiaNetwork@ Network;
    CGameCtnNetServerInfo@ ServerInfo;

    bool isOnServer;

    uint DownloadRate;
    uint UploadRate;
    float PacketLossRate;
    int Ping;
    bool canDoUDP;

    uint TotalSendSize;
    uint TotalRecvSize;
    uint TotalTCPUDPRecvSize;
    uint TotalHTTPRecvSize;
    uint TCPSendSize;
    uint TCPRecvSize;
    uint UDPSendSize;
    uint UDPRecvSize;

    Server()
    {
        @Network = cast<CTrackManiaNetwork>(GetApp().Network);
        @ServerInfo = cast<CGameCtnNetServerInfo>(Network.ServerInfo);
        isOnServer = false;
        this.ResetStats();
    }

    void checkIsOnServer()
    {
        isOnServer = ServerInfo.JoinLink != "";
    }

    // This update is called only when we're on a server
    void Update(float dt)
    {
        DownloadRate = Network.RecvNetRate;
        UploadRate = Network.SendNetRate;
        PacketLossRate = Network.PacketLossRate;
        Ping = Network.LatestGamePing;
        canDoUDP = Network.CanDoUDP == 1;
        TotalSendSize = Network.TotalSendingSize;
        TotalRecvSize = Network.TotalReceivingSize;
        TotalTCPUDPRecvSize = Network.TotalTcpUdpReceivingSize;
        TotalHTTPRecvSize = Network.TotalHttpReceivingSize;
        TCPSendSize = Network.TcpSendingSize;
        TCPRecvSize = Network.TcpReceivingSize;
        UDPSendSize = Network.UdpSendingSize;
        UDPRecvSize = Network.UdpReceivingSize;
    }

    Json::Value ToJson()
    {
        Json::Value json = Json::Object();
        json["isOnServer"] = isOnServer;
        json["DownloadRate"] = DownloadRate;
        json["UploadRate"] = UploadRate;
        json["PacketLossRate"] = PacketLossRate;
        json["Ping"] = Ping;
        json["canDoUDP"] = canDoUDP;
        json["TotalSendSize"] = TotalSendSize;
        json["TotalRecvSize"] = TotalRecvSize;
        json["TotalTCPUDPRecvSize"] = TotalTCPUDPRecvSize;
        json["TotalHTTPRecvSize"] = TotalHTTPRecvSize;
        json["TCPSendSize"] = TCPSendSize;
        json["TCPRecvSize"] = TCPRecvSize;
        json["UDPSendSize"] = UDPSendSize;
        json["UDPRecvSize"] = UDPRecvSize;
        return json;
    }

    // This method is called when we're not on a server
    void ResetStats()
    {
        DownloadRate = 0;
        UploadRate = 0;
        PacketLossRate = 0;
        Ping = 0;
        canDoUDP = false;
        TotalSendSize = 0;
        TotalRecvSize = 0;
        TotalTCPUDPRecvSize = 0;
        TotalHTTPRecvSize = 0;
        TCPSendSize = 0;
        TCPRecvSize = 0;
        UDPSendSize = 0;
        UDPRecvSize = 0;
    }
}