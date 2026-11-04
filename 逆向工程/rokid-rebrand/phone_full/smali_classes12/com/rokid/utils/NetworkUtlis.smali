.class public Lcom/rokid/utils/NetworkUtlis;
.super Ljava/lang/Object;
.source "NetworkUtlis.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/rokid/utils/NetworkUtlis$NetworkType;
    }
.end annotation


# direct methods
.method public constructor <init>()V
    .locals 0

    .line 21
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static getIPAddress()Ljava/lang/String;
    .locals 8

    .line 67
    invoke-static {}, Lcom/rokid/utils/ContextUtil;->getApplicationContext()Landroid/app/Application;

    move-result-object v0

    const-string v1, "connectivity"

    invoke-virtual {v0, v1}, Landroid/app/Application;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/net/ConnectivityManager;

    .line 68
    .local v0, "connectivityManager":Landroid/net/ConnectivityManager;
    const-string v1, ""

    if-nez v0, :cond_0

    .line 69
    return-object v1

    .line 73
    :cond_0
    const/4 v2, 0x0

    .line 75
    .local v2, "activeNetworkInfo":Landroid/net/NetworkInfo;
    :try_start_0
    invoke-virtual {v0}, Landroid/net/ConnectivityManager;->getActiveNetworkInfo()Landroid/net/NetworkInfo;

    move-result-object v3
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    move-object v2, v3

    .line 78
    goto :goto_0

    .line 76
    :catch_0
    move-exception v3

    .line 77
    .local v3, "e":Ljava/lang/Exception;
    invoke-virtual {v3}, Ljava/lang/Exception;->printStackTrace()V

    .line 80
    .end local v3    # "e":Ljava/lang/Exception;
    :goto_0
    if-eqz v2, :cond_9

    invoke-virtual {v2}, Landroid/net/NetworkInfo;->isConnected()Z

    move-result v3

    if-nez v3, :cond_1

    goto :goto_4

    .line 84
    :cond_1
    invoke-virtual {v2}, Landroid/net/NetworkInfo;->getType()I

    move-result v3

    if-nez v3, :cond_5

    .line 86
    :try_start_1
    invoke-static {}, Ljava/net/NetworkInterface;->getNetworkInterfaces()Ljava/util/Enumeration;

    move-result-object v3

    .local v3, "en":Ljava/util/Enumeration;, "Ljava/util/Enumeration<Ljava/net/NetworkInterface;>;"
    :goto_1
    invoke-interface {v3}, Ljava/util/Enumeration;->hasMoreElements()Z

    move-result v4

    if-eqz v4, :cond_4

    .line 87
    invoke-interface {v3}, Ljava/util/Enumeration;->nextElement()Ljava/lang/Object;

    move-result-object v4

    check-cast v4, Ljava/net/NetworkInterface;

    .line 88
    .local v4, "intf":Ljava/net/NetworkInterface;
    invoke-virtual {v4}, Ljava/net/NetworkInterface;->getInetAddresses()Ljava/util/Enumeration;

    move-result-object v5

    .local v5, "enumIpAddr":Ljava/util/Enumeration;, "Ljava/util/Enumeration<Ljava/net/InetAddress;>;"
    :goto_2
    invoke-interface {v5}, Ljava/util/Enumeration;->hasMoreElements()Z

    move-result v6

    if-eqz v6, :cond_3

    .line 89
    invoke-interface {v5}, Ljava/util/Enumeration;->nextElement()Ljava/lang/Object;

    move-result-object v6

    check-cast v6, Ljava/net/InetAddress;

    .line 90
    .local v6, "inetAddress":Ljava/net/InetAddress;
    invoke-virtual {v6}, Ljava/net/InetAddress;->isLoopbackAddress()Z

    move-result v7

    if-nez v7, :cond_2

    instance-of v7, v6, Ljava/net/Inet4Address;

    if-eqz v7, :cond_2

    .line 91
    invoke-virtual {v6}, Ljava/net/InetAddress;->getHostAddress()Ljava/lang/String;

    move-result-object v1
    :try_end_1
    .catch Ljava/net/SocketException; {:try_start_1 .. :try_end_1} :catch_1

    return-object v1

    .line 93
    .end local v6    # "inetAddress":Ljava/net/InetAddress;
    :cond_2
    goto :goto_2

    .line 94
    .end local v4    # "intf":Ljava/net/NetworkInterface;
    .end local v5    # "enumIpAddr":Ljava/util/Enumeration;, "Ljava/util/Enumeration<Ljava/net/InetAddress;>;"
    :cond_3
    goto :goto_1

    .line 97
    .end local v3    # "en":Ljava/util/Enumeration;, "Ljava/util/Enumeration<Ljava/net/NetworkInterface;>;"
    :cond_4
    goto :goto_3

    .line 95
    :catch_1
    move-exception v3

    .line 96
    .local v3, "e":Ljava/net/SocketException;
    invoke-virtual {v3}, Ljava/net/SocketException;->printStackTrace()V

    .line 100
    .end local v3    # "e":Ljava/net/SocketException;
    :cond_5
    :goto_3
    invoke-virtual {v2}, Landroid/net/NetworkInfo;->getType()I

    move-result v3

    const/4 v4, 0x1

    if-ne v3, v4, :cond_8

    .line 102
    invoke-static {}, Lcom/rokid/utils/ContextUtil;->getApplicationContext()Landroid/app/Application;

    move-result-object v3

    const-string/jumbo v4, "wifi"

    invoke-virtual {v3, v4}, Landroid/app/Application;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Landroid/net/wifi/WifiManager;

    .line 103
    .local v3, "wifiManager":Landroid/net/wifi/WifiManager;
    if-nez v3, :cond_6

    .line 104
    return-object v1

    .line 107
    :cond_6
    invoke-virtual {v3}, Landroid/net/wifi/WifiManager;->getConnectionInfo()Landroid/net/wifi/WifiInfo;

    move-result-object v4

    .line 108
    .local v4, "wifiInfo":Landroid/net/wifi/WifiInfo;
    if-nez v4, :cond_7

    .line 109
    return-object v1

    .line 112
    :cond_7
    invoke-virtual {v4}, Landroid/net/wifi/WifiInfo;->getIpAddress()I

    move-result v1

    invoke-static {v1}, Lcom/rokid/utils/NetworkUtlis;->intIP2StringIP(I)Ljava/lang/String;

    move-result-object v1

    return-object v1

    .line 115
    .end local v3    # "wifiManager":Landroid/net/wifi/WifiManager;
    .end local v4    # "wifiInfo":Landroid/net/wifi/WifiInfo;
    :cond_8
    return-object v1

    .line 81
    :cond_9
    :goto_4
    return-object v1
.end method

.method public static getNetWorkState(Landroid/content/Context;)I
    .locals 4
    .param p0, "context"    # Landroid/content/Context;

    .line 44
    nop

    .line 45
    const-string v0, "connectivity"

    invoke-virtual {p0, v0}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/net/ConnectivityManager;

    .line 47
    .local v0, "connectivityManager":Landroid/net/ConnectivityManager;
    if-nez v0, :cond_0

    .line 48
    sget-object v1, Lcom/rokid/utils/NetworkUtlis$NetworkType;->NETWORK_NONE:Lcom/rokid/utils/NetworkUtlis$NetworkType;

    invoke-static {v1}, Lcom/rokid/utils/NetworkUtlis$NetworkType;->access$000(Lcom/rokid/utils/NetworkUtlis$NetworkType;)I

    move-result v1

    return v1

    .line 51
    :cond_0
    invoke-virtual {v0}, Landroid/net/ConnectivityManager;->getActiveNetworkInfo()Landroid/net/NetworkInfo;

    move-result-object v1

    .line 53
    .local v1, "activeNetworkInfo":Landroid/net/NetworkInfo;
    if-eqz v1, :cond_3

    invoke-virtual {v1}, Landroid/net/NetworkInfo;->isConnected()Z

    move-result v2

    if-eqz v2, :cond_3

    .line 54
    invoke-virtual {v1}, Landroid/net/NetworkInfo;->getType()I

    move-result v2

    const/4 v3, 0x1

    if-ne v2, v3, :cond_1

    .line 55
    sget-object v2, Lcom/rokid/utils/NetworkUtlis$NetworkType;->NETWORK_WIFI:Lcom/rokid/utils/NetworkUtlis$NetworkType;

    invoke-virtual {v2}, Lcom/rokid/utils/NetworkUtlis$NetworkType;->value()I

    move-result v2

    return v2

    .line 56
    :cond_1
    invoke-virtual {v1}, Landroid/net/NetworkInfo;->getType()I

    move-result v2

    if-nez v2, :cond_2

    .line 57
    sget-object v2, Lcom/rokid/utils/NetworkUtlis$NetworkType;->NETWORK_MOBILE:Lcom/rokid/utils/NetworkUtlis$NetworkType;

    invoke-virtual {v2}, Lcom/rokid/utils/NetworkUtlis$NetworkType;->value()I

    move-result v2

    return v2

    .line 58
    :cond_2
    invoke-virtual {v1}, Landroid/net/NetworkInfo;->getType()I

    move-result v2

    const/16 v3, 0x9

    if-ne v2, v3, :cond_3

    .line 59
    sget-object v2, Lcom/rokid/utils/NetworkUtlis$NetworkType;->NETWORK_ETHERNET:Lcom/rokid/utils/NetworkUtlis$NetworkType;

    invoke-virtual {v2}, Lcom/rokid/utils/NetworkUtlis$NetworkType;->value()I

    move-result v2

    return v2

    .line 62
    :cond_3
    sget-object v2, Lcom/rokid/utils/NetworkUtlis$NetworkType;->NETWORK_NONE:Lcom/rokid/utils/NetworkUtlis$NetworkType;

    invoke-virtual {v2}, Lcom/rokid/utils/NetworkUtlis$NetworkType;->value()I

    move-result v2

    return v2
.end method

.method private static intIP2StringIP(I)Ljava/lang/String;
    .locals 3
    .param p0, "ip"    # I

    .line 122
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    and-int/lit16 v1, p0, 0xff

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "."

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    shr-int/lit8 v2, p0, 0x8

    and-int/lit16 v2, v2, 0xff

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    shr-int/lit8 v2, p0, 0x10

    and-int/lit16 v2, v2, 0xff

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    shr-int/lit8 v1, p0, 0x18

    and-int/lit16 v1, v1, 0xff

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method
