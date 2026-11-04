.class public Lcom/rokid/utils/NetworkUtils;
.super Ljava/lang/Object;
.source "NetworkUtils.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/rokid/utils/NetworkUtils$NetworkType;
    }
.end annotation


# static fields
.field private static instance:Lcom/rokid/utils/NetworkUtils;


# instance fields
.field private mContext:Landroid/content/Context;


# direct methods
.method public constructor <init>()V
    .locals 0

    .line 19
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static getNetWorkState(Landroid/content/Context;)I
    .locals 4
    .param p0, "context"    # Landroid/content/Context;

    .line 56
    nop

    .line 57
    const-string v0, "connectivity"

    invoke-virtual {p0, v0}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/net/ConnectivityManager;

    .line 59
    .local v0, "connectivityManager":Landroid/net/ConnectivityManager;
    if-nez v0, :cond_0

    .line 60
    sget-object v1, Lcom/rokid/utils/NetworkUtils$NetworkType;->NETWORK_NONE:Lcom/rokid/utils/NetworkUtils$NetworkType;

    invoke-static {v1}, Lcom/rokid/utils/NetworkUtils$NetworkType;->access$000(Lcom/rokid/utils/NetworkUtils$NetworkType;)I

    move-result v1

    return v1

    .line 63
    :cond_0
    invoke-virtual {v0}, Landroid/net/ConnectivityManager;->getActiveNetworkInfo()Landroid/net/NetworkInfo;

    move-result-object v1

    .line 65
    .local v1, "activeNetworkInfo":Landroid/net/NetworkInfo;
    if-eqz v1, :cond_3

    invoke-virtual {v1}, Landroid/net/NetworkInfo;->isConnected()Z

    move-result v2

    if-eqz v2, :cond_3

    .line 66
    invoke-virtual {v1}, Landroid/net/NetworkInfo;->getType()I

    move-result v2

    const/4 v3, 0x1

    if-ne v2, v3, :cond_1

    .line 67
    sget-object v2, Lcom/rokid/utils/NetworkUtils$NetworkType;->NETWORK_WIFI:Lcom/rokid/utils/NetworkUtils$NetworkType;

    invoke-virtual {v2}, Lcom/rokid/utils/NetworkUtils$NetworkType;->value()I

    move-result v2

    return v2

    .line 68
    :cond_1
    invoke-virtual {v1}, Landroid/net/NetworkInfo;->getType()I

    move-result v2

    if-nez v2, :cond_2

    .line 69
    sget-object v2, Lcom/rokid/utils/NetworkUtils$NetworkType;->NETWORK_MOBILE:Lcom/rokid/utils/NetworkUtils$NetworkType;

    invoke-virtual {v2}, Lcom/rokid/utils/NetworkUtils$NetworkType;->value()I

    move-result v2

    return v2

    .line 70
    :cond_2
    invoke-virtual {v1}, Landroid/net/NetworkInfo;->getType()I

    move-result v2

    const/16 v3, 0x9

    if-ne v2, v3, :cond_3

    .line 71
    sget-object v2, Lcom/rokid/utils/NetworkUtils$NetworkType;->NETWORK_ETHERNET:Lcom/rokid/utils/NetworkUtils$NetworkType;

    invoke-virtual {v2}, Lcom/rokid/utils/NetworkUtils$NetworkType;->value()I

    move-result v2

    return v2

    .line 74
    :cond_3
    sget-object v2, Lcom/rokid/utils/NetworkUtils$NetworkType;->NETWORK_NONE:Lcom/rokid/utils/NetworkUtils$NetworkType;

    invoke-virtual {v2}, Lcom/rokid/utils/NetworkUtils$NetworkType;->value()I

    move-result v2

    return v2
.end method

.method private intIP2StringIP(I)Ljava/lang/String;
    .locals 3
    .param p1, "ip"    # I

    .line 167
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    and-int/lit16 v1, p1, 0xff

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "."

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    shr-int/lit8 v2, p1, 0x8

    and-int/lit16 v2, v2, 0xff

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    shr-int/lit8 v2, p1, 0x10

    and-int/lit16 v2, v2, 0xff

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    shr-int/lit8 v1, p1, 0x18

    and-int/lit16 v1, v1, 0xff

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method


# virtual methods
.method public getIPAddress()Ljava/lang/String;
    .locals 8

    .line 108
    iget-object v0, p0, Lcom/rokid/utils/NetworkUtils;->mContext:Landroid/content/Context;

    if-nez v0, :cond_0

    .line 109
    const/4 v0, 0x0

    return-object v0

    .line 111
    :cond_0
    iget-object v0, p0, Lcom/rokid/utils/NetworkUtils;->mContext:Landroid/content/Context;

    .line 112
    const-string v1, "connectivity"

    invoke-virtual {v0, v1}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/net/ConnectivityManager;

    .line 113
    .local v0, "connectivityManager":Landroid/net/ConnectivityManager;
    const-string v1, ""

    if-nez v0, :cond_1

    .line 114
    return-object v1

    .line 118
    :cond_1
    const/4 v2, 0x0

    .line 120
    .local v2, "activeNetworkInfo":Landroid/net/NetworkInfo;
    :try_start_0
    invoke-virtual {v0}, Landroid/net/ConnectivityManager;->getActiveNetworkInfo()Landroid/net/NetworkInfo;

    move-result-object v3
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    move-object v2, v3

    .line 123
    goto :goto_0

    .line 121
    :catch_0
    move-exception v3

    .line 122
    .local v3, "e":Ljava/lang/Exception;
    invoke-virtual {v3}, Ljava/lang/Exception;->printStackTrace()V

    .line 125
    .end local v3    # "e":Ljava/lang/Exception;
    :goto_0
    if-eqz v2, :cond_a

    invoke-virtual {v2}, Landroid/net/NetworkInfo;->isConnected()Z

    move-result v3

    if-nez v3, :cond_2

    goto :goto_4

    .line 129
    :cond_2
    invoke-virtual {v2}, Landroid/net/NetworkInfo;->getType()I

    move-result v3

    if-nez v3, :cond_6

    .line 131
    :try_start_1
    invoke-static {}, Ljava/net/NetworkInterface;->getNetworkInterfaces()Ljava/util/Enumeration;

    move-result-object v3

    .local v3, "en":Ljava/util/Enumeration;, "Ljava/util/Enumeration<Ljava/net/NetworkInterface;>;"
    :goto_1
    invoke-interface {v3}, Ljava/util/Enumeration;->hasMoreElements()Z

    move-result v4

    if-eqz v4, :cond_5

    .line 132
    invoke-interface {v3}, Ljava/util/Enumeration;->nextElement()Ljava/lang/Object;

    move-result-object v4

    check-cast v4, Ljava/net/NetworkInterface;

    .line 133
    .local v4, "intf":Ljava/net/NetworkInterface;
    invoke-virtual {v4}, Ljava/net/NetworkInterface;->getInetAddresses()Ljava/util/Enumeration;

    move-result-object v5

    .local v5, "enumIpAddr":Ljava/util/Enumeration;, "Ljava/util/Enumeration<Ljava/net/InetAddress;>;"
    :goto_2
    invoke-interface {v5}, Ljava/util/Enumeration;->hasMoreElements()Z

    move-result v6

    if-eqz v6, :cond_4

    .line 134
    invoke-interface {v5}, Ljava/util/Enumeration;->nextElement()Ljava/lang/Object;

    move-result-object v6

    check-cast v6, Ljava/net/InetAddress;

    .line 135
    .local v6, "inetAddress":Ljava/net/InetAddress;
    invoke-virtual {v6}, Ljava/net/InetAddress;->isLoopbackAddress()Z

    move-result v7

    if-nez v7, :cond_3

    instance-of v7, v6, Ljava/net/Inet4Address;

    if-eqz v7, :cond_3

    .line 136
    invoke-virtual {v6}, Ljava/net/InetAddress;->getHostAddress()Ljava/lang/String;

    move-result-object v1
    :try_end_1
    .catch Ljava/net/SocketException; {:try_start_1 .. :try_end_1} :catch_1

    return-object v1

    .line 138
    .end local v6    # "inetAddress":Ljava/net/InetAddress;
    :cond_3
    goto :goto_2

    .line 139
    .end local v4    # "intf":Ljava/net/NetworkInterface;
    .end local v5    # "enumIpAddr":Ljava/util/Enumeration;, "Ljava/util/Enumeration<Ljava/net/InetAddress;>;"
    :cond_4
    goto :goto_1

    .line 142
    .end local v3    # "en":Ljava/util/Enumeration;, "Ljava/util/Enumeration<Ljava/net/NetworkInterface;>;"
    :cond_5
    goto :goto_3

    .line 140
    :catch_1
    move-exception v3

    .line 141
    .local v3, "e":Ljava/net/SocketException;
    invoke-virtual {v3}, Ljava/net/SocketException;->printStackTrace()V

    .line 145
    .end local v3    # "e":Ljava/net/SocketException;
    :cond_6
    :goto_3
    invoke-virtual {v2}, Landroid/net/NetworkInfo;->getType()I

    move-result v3

    const/4 v4, 0x1

    if-ne v3, v4, :cond_9

    .line 146
    iget-object v3, p0, Lcom/rokid/utils/NetworkUtils;->mContext:Landroid/content/Context;

    .line 147
    invoke-virtual {v3}, Landroid/content/Context;->getApplicationContext()Landroid/content/Context;

    move-result-object v3

    const-string/jumbo v4, "wifi"

    invoke-virtual {v3, v4}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Landroid/net/wifi/WifiManager;

    .line 148
    .local v3, "wifiManager":Landroid/net/wifi/WifiManager;
    if-nez v3, :cond_7

    .line 149
    return-object v1

    .line 152
    :cond_7
    invoke-virtual {v3}, Landroid/net/wifi/WifiManager;->getConnectionInfo()Landroid/net/wifi/WifiInfo;

    move-result-object v4

    .line 153
    .local v4, "wifiInfo":Landroid/net/wifi/WifiInfo;
    if-nez v4, :cond_8

    .line 154
    return-object v1

    .line 157
    :cond_8
    invoke-virtual {v4}, Landroid/net/wifi/WifiInfo;->getIpAddress()I

    move-result v1

    invoke-direct {p0, v1}, Lcom/rokid/utils/NetworkUtils;->intIP2StringIP(I)Ljava/lang/String;

    move-result-object v1

    return-object v1

    .line 160
    .end local v3    # "wifiManager":Landroid/net/wifi/WifiManager;
    .end local v4    # "wifiInfo":Landroid/net/wifi/WifiInfo;
    :cond_9
    return-object v1

    .line 126
    :cond_a
    :goto_4
    return-object v1
.end method

.method public getInstance()Lcom/rokid/utils/NetworkUtils;
    .locals 1

    .line 25
    sget-object v0, Lcom/rokid/utils/NetworkUtils;->instance:Lcom/rokid/utils/NetworkUtils;

    if-nez v0, :cond_0

    .line 26
    new-instance v0, Lcom/rokid/utils/NetworkUtils;

    invoke-direct {v0}, Lcom/rokid/utils/NetworkUtils;-><init>()V

    sput-object v0, Lcom/rokid/utils/NetworkUtils;->instance:Lcom/rokid/utils/NetworkUtils;

    .line 28
    :cond_0
    sget-object v0, Lcom/rokid/utils/NetworkUtils;->instance:Lcom/rokid/utils/NetworkUtils;

    return-object v0
.end method

.method public init(Landroid/content/Context;)V
    .locals 0
    .param p1, "context"    # Landroid/content/Context;

    .line 32
    iput-object p1, p0, Lcom/rokid/utils/NetworkUtils;->mContext:Landroid/content/Context;

    .line 33
    return-void
.end method

.method public isConnect()Z
    .locals 5

    .line 78
    iget-object v0, p0, Lcom/rokid/utils/NetworkUtils;->mContext:Landroid/content/Context;

    const/4 v1, 0x0

    if-nez v0, :cond_0

    .line 79
    return v1

    .line 81
    :cond_0
    iget-object v0, p0, Lcom/rokid/utils/NetworkUtils;->mContext:Landroid/content/Context;

    .line 82
    const-string v2, "connectivity"

    invoke-virtual {v0, v2}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/net/ConnectivityManager;

    .line 83
    .local v0, "connectivityManager":Landroid/net/ConnectivityManager;
    if-nez v0, :cond_1

    .line 84
    return v1

    .line 88
    :cond_1
    const/4 v2, 0x0

    .line 90
    .local v2, "activeNetworkInfo":Landroid/net/NetworkInfo;
    :try_start_0
    invoke-virtual {v0}, Landroid/net/ConnectivityManager;->getActiveNetworkInfo()Landroid/net/NetworkInfo;

    move-result-object v3
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    move-object v2, v3

    .line 93
    goto :goto_0

    .line 91
    :catch_0
    move-exception v3

    .line 92
    .local v3, "e":Ljava/lang/Exception;
    invoke-virtual {v3}, Ljava/lang/Exception;->printStackTrace()V

    .line 95
    .end local v3    # "e":Ljava/lang/Exception;
    :goto_0
    if-eqz v2, :cond_5

    invoke-virtual {v2}, Landroid/net/NetworkInfo;->isAvailable()Z

    move-result v3

    if-eqz v3, :cond_5

    invoke-virtual {v2}, Landroid/net/NetworkInfo;->isConnected()Z

    move-result v3

    if-nez v3, :cond_2

    goto :goto_2

    .line 99
    :cond_2
    invoke-virtual {v2}, Landroid/net/NetworkInfo;->getType()I

    move-result v3

    const/4 v4, 0x1

    if-eq v4, v3, :cond_4

    .line 100
    invoke-virtual {v2}, Landroid/net/NetworkInfo;->getType()I

    move-result v3

    if-nez v3, :cond_3

    goto :goto_1

    .line 104
    :cond_3
    return v1

    .line 101
    :cond_4
    :goto_1
    return v4

    .line 96
    :cond_5
    :goto_2
    return v1
.end method
