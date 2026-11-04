.class public final Lcom/rokid/security/sdk/base/common/outside/DeviceGbPlatformConfigVO;
.super Ljava/lang/Object;
.source "GB28181CloudModels.kt"


# annotations
.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000*\n\u0002\u0018\u0002\n\u0002\u0010\u0000\n\u0000\n\u0002\u0010\u000e\n\u0002\u0008\u0005\n\u0002\u0010\u0008\n\u0002\u0008\u0017\n\u0002\u0010\u000b\n\u0002\u0008\u0006\n\u0002\u0018\u0002\n\u0002\u0008\u0002\u0008\u0086\u0008\u0018\u00002\u00020\u0001Bc\u0012\n\u0008\u0002\u0010\u0002\u001a\u0004\u0018\u00010\u0003\u0012\n\u0008\u0002\u0010\u0004\u001a\u0004\u0018\u00010\u0003\u0012\n\u0008\u0002\u0010\u0005\u001a\u0004\u0018\u00010\u0003\u0012\n\u0008\u0002\u0010\u0006\u001a\u0004\u0018\u00010\u0003\u0012\n\u0008\u0002\u0010\u0007\u001a\u0004\u0018\u00010\u0003\u0012\u0008\u0008\u0002\u0010\u0008\u001a\u00020\t\u0012\n\u0008\u0002\u0010\n\u001a\u0004\u0018\u00010\u0003\u0012\n\u0008\u0002\u0010\u000b\u001a\u0004\u0018\u00010\u0003\u00a2\u0006\u0002\u0010\u000cJ\u000b\u0010\u0017\u001a\u0004\u0018\u00010\u0003H\u00c6\u0003J\u000b\u0010\u0018\u001a\u0004\u0018\u00010\u0003H\u00c6\u0003J\u000b\u0010\u0019\u001a\u0004\u0018\u00010\u0003H\u00c6\u0003J\u000b\u0010\u001a\u001a\u0004\u0018\u00010\u0003H\u00c6\u0003J\u000b\u0010\u001b\u001a\u0004\u0018\u00010\u0003H\u00c6\u0003J\t\u0010\u001c\u001a\u00020\tH\u00c6\u0003J\u000b\u0010\u001d\u001a\u0004\u0018\u00010\u0003H\u00c6\u0003J\u000b\u0010\u001e\u001a\u0004\u0018\u00010\u0003H\u00c6\u0003Jg\u0010\u001f\u001a\u00020\u00002\n\u0008\u0002\u0010\u0002\u001a\u0004\u0018\u00010\u00032\n\u0008\u0002\u0010\u0004\u001a\u0004\u0018\u00010\u00032\n\u0008\u0002\u0010\u0005\u001a\u0004\u0018\u00010\u00032\n\u0008\u0002\u0010\u0006\u001a\u0004\u0018\u00010\u00032\n\u0008\u0002\u0010\u0007\u001a\u0004\u0018\u00010\u00032\u0008\u0008\u0002\u0010\u0008\u001a\u00020\t2\n\u0008\u0002\u0010\n\u001a\u0004\u0018\u00010\u00032\n\u0008\u0002\u0010\u000b\u001a\u0004\u0018\u00010\u0003H\u00c6\u0001J\u0013\u0010 \u001a\u00020!2\u0008\u0010\"\u001a\u0004\u0018\u00010\u0001H\u00d6\u0003J\t\u0010#\u001a\u00020\tH\u00d6\u0001J\u0006\u0010$\u001a\u00020!J\u0006\u0010%\u001a\u00020\tJ\t\u0010&\u001a\u00020\u0003H\u00d6\u0001J\u000e\u0010\'\u001a\u00020(2\u0006\u0010)\u001a\u00020\tR\u0018\u0010\u0002\u001a\u0004\u0018\u00010\u00038\u0006X\u0087\u0004\u00a2\u0006\u0008\n\u0000\u001a\u0004\u0008\r\u0010\u000eR\u0018\u0010\u000b\u001a\u0004\u0018\u00010\u00038\u0006X\u0087\u0004\u00a2\u0006\u0008\n\u0000\u001a\u0004\u0008\u000f\u0010\u000eR\u0018\u0010\u0005\u001a\u0004\u0018\u00010\u00038\u0006X\u0087\u0004\u00a2\u0006\u0008\n\u0000\u001a\u0004\u0008\u0010\u0010\u000eR\u0018\u0010\u0004\u001a\u0004\u0018\u00010\u00038\u0006X\u0087\u0004\u00a2\u0006\u0008\n\u0000\u001a\u0004\u0008\u0011\u0010\u000eR\u0018\u0010\u0006\u001a\u0004\u0018\u00010\u00038\u0006X\u0087\u0004\u00a2\u0006\u0008\n\u0000\u001a\u0004\u0008\u0012\u0010\u000eR\u0018\u0010\u0007\u001a\u0004\u0018\u00010\u00038\u0006X\u0087\u0004\u00a2\u0006\u0008\n\u0000\u001a\u0004\u0008\u0013\u0010\u000eR\u0016\u0010\u0008\u001a\u00020\t8\u0006X\u0087\u0004\u00a2\u0006\u0008\n\u0000\u001a\u0004\u0008\u0014\u0010\u0015R\u0018\u0010\n\u001a\u0004\u0018\u00010\u00038\u0006X\u0087\u0004\u00a2\u0006\u0008\n\u0000\u001a\u0004\u0008\u0016\u0010\u000e\u00a8\u0006*"
    }
    d2 = {
        "Lcom/rokid/security/sdk/base/common/outside/DeviceGbPlatformConfigVO;",
        "",
        "deviceCode",
        "",
        "password",
        "name",
        "sipServerId",
        "sipServerIp",
        "sipServerPort",
        "",
        "transportProtocol",
        "domain",
        "(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;ILjava/lang/String;Ljava/lang/String;)V",
        "getDeviceCode",
        "()Ljava/lang/String;",
        "getDomain",
        "getName",
        "getPassword",
        "getSipServerId",
        "getSipServerIp",
        "getSipServerPort",
        "()I",
        "getTransportProtocol",
        "component1",
        "component2",
        "component3",
        "component4",
        "component5",
        "component6",
        "component7",
        "component8",
        "copy",
        "equals",
        "",
        "other",
        "hashCode",
        "isValid",
        "toConfigFingerprint",
        "toString",
        "toSyncConfig",
        "Lcom/rokid/security/sdk/base/common/outside/GB28181SyncConfig;",
        "configFingerprint",
        "sdk-base-common_release"
    }
    k = 0x1
    mv = {
        0x1,
        0x8,
        0x0
    }
    xi = 0x30
.end annotation


# instance fields
.field private final deviceCode:Ljava/lang/String;
    .annotation runtime Lcom/google/gson/annotations/SerializedName;
        value = "deviceCode"
    .end annotation
.end field

.field private final domain:Ljava/lang/String;
    .annotation runtime Lcom/google/gson/annotations/SerializedName;
        value = "domain"
    .end annotation
.end field

.field private final name:Ljava/lang/String;
    .annotation runtime Lcom/google/gson/annotations/SerializedName;
        value = "name"
    .end annotation
.end field

.field private final password:Ljava/lang/String;
    .annotation runtime Lcom/google/gson/annotations/SerializedName;
        value = "password"
    .end annotation
.end field

.field private final sipServerId:Ljava/lang/String;
    .annotation runtime Lcom/google/gson/annotations/SerializedName;
        value = "sipServerId"
    .end annotation
.end field

.field private final sipServerIp:Ljava/lang/String;
    .annotation runtime Lcom/google/gson/annotations/SerializedName;
        value = "sipServerIp"
    .end annotation
.end field

.field private final sipServerPort:I
    .annotation runtime Lcom/google/gson/annotations/SerializedName;
        value = "sipServerPort"
    .end annotation
.end field

.field private final transportProtocol:Ljava/lang/String;
    .annotation runtime Lcom/google/gson/annotations/SerializedName;
        value = "transportProtocol"
    .end annotation
.end field


# direct methods
.method public constructor <init>()V
    .locals 11

    const/16 v9, 0xff

    const/4 v10, 0x0

    const/4 v1, 0x0

    const/4 v2, 0x0

    const/4 v3, 0x0

    const/4 v4, 0x0

    const/4 v5, 0x0

    const/4 v6, 0x0

    const/4 v7, 0x0

    const/4 v8, 0x0

    move-object v0, p0

    invoke-direct/range {v0 .. v10}, Lcom/rokid/security/sdk/base/common/outside/DeviceGbPlatformConfigVO;-><init>(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;ILjava/lang/String;Ljava/lang/String;ILkotlin/jvm/internal/DefaultConstructorMarker;)V

    return-void
.end method

.method public constructor <init>(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;ILjava/lang/String;Ljava/lang/String;)V
    .locals 0
    .param p1, "deviceCode"    # Ljava/lang/String;
    .param p2, "password"    # Ljava/lang/String;
    .param p3, "name"    # Ljava/lang/String;
    .param p4, "sipServerId"    # Ljava/lang/String;
    .param p5, "sipServerIp"    # Ljava/lang/String;
    .param p6, "sipServerPort"    # I
    .param p7, "transportProtocol"    # Ljava/lang/String;
    .param p8, "domain"    # Ljava/lang/String;

    .line 21
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 22
    iput-object p1, p0, Lcom/rokid/security/sdk/base/common/outside/DeviceGbPlatformConfigVO;->deviceCode:Ljava/lang/String;

    .line 24
    iput-object p2, p0, Lcom/rokid/security/sdk/base/common/outside/DeviceGbPlatformConfigVO;->password:Ljava/lang/String;

    .line 26
    iput-object p3, p0, Lcom/rokid/security/sdk/base/common/outside/DeviceGbPlatformConfigVO;->name:Ljava/lang/String;

    .line 28
    iput-object p4, p0, Lcom/rokid/security/sdk/base/common/outside/DeviceGbPlatformConfigVO;->sipServerId:Ljava/lang/String;

    .line 30
    iput-object p5, p0, Lcom/rokid/security/sdk/base/common/outside/DeviceGbPlatformConfigVO;->sipServerIp:Ljava/lang/String;

    .line 32
    iput p6, p0, Lcom/rokid/security/sdk/base/common/outside/DeviceGbPlatformConfigVO;->sipServerPort:I

    .line 34
    iput-object p7, p0, Lcom/rokid/security/sdk/base/common/outside/DeviceGbPlatformConfigVO;->transportProtocol:Ljava/lang/String;

    .line 36
    iput-object p8, p0, Lcom/rokid/security/sdk/base/common/outside/DeviceGbPlatformConfigVO;->domain:Ljava/lang/String;

    .line 21
    return-void
.end method

.method public synthetic constructor <init>(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;ILjava/lang/String;Ljava/lang/String;ILkotlin/jvm/internal/DefaultConstructorMarker;)V
    .locals 9

    .line 21
    move/from16 v0, p9

    and-int/lit8 v1, v0, 0x1

    const/4 v2, 0x0

    if-eqz v1, :cond_0

    .line 23
    move-object v1, v2

    goto :goto_0

    .line 21
    :cond_0
    move-object v1, p1

    :goto_0
    and-int/lit8 v3, v0, 0x2

    if-eqz v3, :cond_1

    .line 25
    move-object v3, v2

    goto :goto_1

    .line 21
    :cond_1
    move-object v3, p2

    :goto_1
    and-int/lit8 v4, v0, 0x4

    if-eqz v4, :cond_2

    .line 27
    move-object v4, v2

    goto :goto_2

    .line 21
    :cond_2
    move-object v4, p3

    :goto_2
    and-int/lit8 v5, v0, 0x8

    if-eqz v5, :cond_3

    .line 29
    move-object v5, v2

    goto :goto_3

    .line 21
    :cond_3
    move-object v5, p4

    :goto_3
    and-int/lit8 v6, v0, 0x10

    if-eqz v6, :cond_4

    .line 31
    move-object v6, v2

    goto :goto_4

    .line 21
    :cond_4
    move-object v6, p5

    :goto_4
    and-int/lit8 v7, v0, 0x20

    if-eqz v7, :cond_5

    .line 33
    const/4 v7, 0x0

    goto :goto_5

    .line 21
    :cond_5
    move v7, p6

    :goto_5
    and-int/lit8 v8, v0, 0x40

    if-eqz v8, :cond_6

    .line 35
    move-object v8, v2

    goto :goto_6

    .line 21
    :cond_6
    move-object/from16 v8, p7

    :goto_6
    and-int/lit16 v0, v0, 0x80

    if-eqz v0, :cond_7

    .line 37
    goto :goto_7

    .line 21
    :cond_7
    move-object/from16 v2, p8

    :goto_7
    move-object p1, p0

    move-object p2, v1

    move-object p3, v3

    move-object p4, v4

    move-object p5, v5

    move-object p6, v6

    move/from16 p7, v7

    move-object/from16 p8, v8

    move-object/from16 p9, v2

    invoke-direct/range {p1 .. p9}, Lcom/rokid/security/sdk/base/common/outside/DeviceGbPlatformConfigVO;-><init>(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;ILjava/lang/String;Ljava/lang/String;)V

    .line 75
    return-void
.end method

.method public static synthetic copy$default(Lcom/rokid/security/sdk/base/common/outside/DeviceGbPlatformConfigVO;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;ILjava/lang/String;Ljava/lang/String;ILjava/lang/Object;)Lcom/rokid/security/sdk/base/common/outside/DeviceGbPlatformConfigVO;
    .locals 9

    move-object v0, p0

    move/from16 v1, p9

    and-int/lit8 v2, v1, 0x1

    if-eqz v2, :cond_0

    iget-object v2, v0, Lcom/rokid/security/sdk/base/common/outside/DeviceGbPlatformConfigVO;->deviceCode:Ljava/lang/String;

    goto :goto_0

    :cond_0
    move-object v2, p1

    :goto_0
    and-int/lit8 v3, v1, 0x2

    if-eqz v3, :cond_1

    iget-object v3, v0, Lcom/rokid/security/sdk/base/common/outside/DeviceGbPlatformConfigVO;->password:Ljava/lang/String;

    goto :goto_1

    :cond_1
    move-object v3, p2

    :goto_1
    and-int/lit8 v4, v1, 0x4

    if-eqz v4, :cond_2

    iget-object v4, v0, Lcom/rokid/security/sdk/base/common/outside/DeviceGbPlatformConfigVO;->name:Ljava/lang/String;

    goto :goto_2

    :cond_2
    move-object v4, p3

    :goto_2
    and-int/lit8 v5, v1, 0x8

    if-eqz v5, :cond_3

    iget-object v5, v0, Lcom/rokid/security/sdk/base/common/outside/DeviceGbPlatformConfigVO;->sipServerId:Ljava/lang/String;

    goto :goto_3

    :cond_3
    move-object v5, p4

    :goto_3
    and-int/lit8 v6, v1, 0x10

    if-eqz v6, :cond_4

    iget-object v6, v0, Lcom/rokid/security/sdk/base/common/outside/DeviceGbPlatformConfigVO;->sipServerIp:Ljava/lang/String;

    goto :goto_4

    :cond_4
    move-object v6, p5

    :goto_4
    and-int/lit8 v7, v1, 0x20

    if-eqz v7, :cond_5

    iget v7, v0, Lcom/rokid/security/sdk/base/common/outside/DeviceGbPlatformConfigVO;->sipServerPort:I

    goto :goto_5

    :cond_5
    move v7, p6

    :goto_5
    and-int/lit8 v8, v1, 0x40

    if-eqz v8, :cond_6

    iget-object v8, v0, Lcom/rokid/security/sdk/base/common/outside/DeviceGbPlatformConfigVO;->transportProtocol:Ljava/lang/String;

    goto :goto_6

    :cond_6
    move-object/from16 v8, p7

    :goto_6
    and-int/lit16 v1, v1, 0x80

    if-eqz v1, :cond_7

    iget-object v1, v0, Lcom/rokid/security/sdk/base/common/outside/DeviceGbPlatformConfigVO;->domain:Ljava/lang/String;

    goto :goto_7

    :cond_7
    move-object/from16 v1, p8

    :goto_7
    move-object p1, v2

    move-object p2, v3

    move-object p3, v4

    move-object p4, v5

    move-object p5, v6

    move p6, v7

    move-object/from16 p7, v8

    move-object/from16 p8, v1

    invoke-virtual/range {p0 .. p8}, Lcom/rokid/security/sdk/base/common/outside/DeviceGbPlatformConfigVO;->copy(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;ILjava/lang/String;Ljava/lang/String;)Lcom/rokid/security/sdk/base/common/outside/DeviceGbPlatformConfigVO;

    move-result-object v0

    return-object v0
.end method


# virtual methods
.method public final component1()Ljava/lang/String;
    .locals 1

    iget-object v0, p0, Lcom/rokid/security/sdk/base/common/outside/DeviceGbPlatformConfigVO;->deviceCode:Ljava/lang/String;

    return-object v0
.end method

.method public final component2()Ljava/lang/String;
    .locals 1

    iget-object v0, p0, Lcom/rokid/security/sdk/base/common/outside/DeviceGbPlatformConfigVO;->password:Ljava/lang/String;

    return-object v0
.end method

.method public final component3()Ljava/lang/String;
    .locals 1

    iget-object v0, p0, Lcom/rokid/security/sdk/base/common/outside/DeviceGbPlatformConfigVO;->name:Ljava/lang/String;

    return-object v0
.end method

.method public final component4()Ljava/lang/String;
    .locals 1

    iget-object v0, p0, Lcom/rokid/security/sdk/base/common/outside/DeviceGbPlatformConfigVO;->sipServerId:Ljava/lang/String;

    return-object v0
.end method

.method public final component5()Ljava/lang/String;
    .locals 1

    iget-object v0, p0, Lcom/rokid/security/sdk/base/common/outside/DeviceGbPlatformConfigVO;->sipServerIp:Ljava/lang/String;

    return-object v0
.end method

.method public final component6()I
    .locals 1

    iget v0, p0, Lcom/rokid/security/sdk/base/common/outside/DeviceGbPlatformConfigVO;->sipServerPort:I

    return v0
.end method

.method public final component7()Ljava/lang/String;
    .locals 1

    iget-object v0, p0, Lcom/rokid/security/sdk/base/common/outside/DeviceGbPlatformConfigVO;->transportProtocol:Ljava/lang/String;

    return-object v0
.end method

.method public final component8()Ljava/lang/String;
    .locals 1

    iget-object v0, p0, Lcom/rokid/security/sdk/base/common/outside/DeviceGbPlatformConfigVO;->domain:Ljava/lang/String;

    return-object v0
.end method

.method public final copy(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;ILjava/lang/String;Ljava/lang/String;)Lcom/rokid/security/sdk/base/common/outside/DeviceGbPlatformConfigVO;
    .locals 10

    new-instance v9, Lcom/rokid/security/sdk/base/common/outside/DeviceGbPlatformConfigVO;

    move-object v0, v9

    move-object v1, p1

    move-object v2, p2

    move-object v3, p3

    move-object v4, p4

    move-object v5, p5

    move/from16 v6, p6

    move-object/from16 v7, p7

    move-object/from16 v8, p8

    invoke-direct/range {v0 .. v8}, Lcom/rokid/security/sdk/base/common/outside/DeviceGbPlatformConfigVO;-><init>(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;ILjava/lang/String;Ljava/lang/String;)V

    return-object v9
.end method

.method public equals(Ljava/lang/Object;)Z
    .locals 5

    const/4 v0, 0x1

    if-ne p0, p1, :cond_0

    return v0

    :cond_0
    instance-of v1, p1, Lcom/rokid/security/sdk/base/common/outside/DeviceGbPlatformConfigVO;

    const/4 v2, 0x0

    if-nez v1, :cond_1

    return v2

    :cond_1
    move-object v1, p1

    check-cast v1, Lcom/rokid/security/sdk/base/common/outside/DeviceGbPlatformConfigVO;

    iget-object v3, p0, Lcom/rokid/security/sdk/base/common/outside/DeviceGbPlatformConfigVO;->deviceCode:Ljava/lang/String;

    iget-object v4, v1, Lcom/rokid/security/sdk/base/common/outside/DeviceGbPlatformConfigVO;->deviceCode:Ljava/lang/String;

    invoke-static {v3, v4}, Lkotlin/jvm/internal/Intrinsics;->areEqual(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v3

    if-nez v3, :cond_2

    return v2

    :cond_2
    iget-object v3, p0, Lcom/rokid/security/sdk/base/common/outside/DeviceGbPlatformConfigVO;->password:Ljava/lang/String;

    iget-object v4, v1, Lcom/rokid/security/sdk/base/common/outside/DeviceGbPlatformConfigVO;->password:Ljava/lang/String;

    invoke-static {v3, v4}, Lkotlin/jvm/internal/Intrinsics;->areEqual(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v3

    if-nez v3, :cond_3

    return v2

    :cond_3
    iget-object v3, p0, Lcom/rokid/security/sdk/base/common/outside/DeviceGbPlatformConfigVO;->name:Ljava/lang/String;

    iget-object v4, v1, Lcom/rokid/security/sdk/base/common/outside/DeviceGbPlatformConfigVO;->name:Ljava/lang/String;

    invoke-static {v3, v4}, Lkotlin/jvm/internal/Intrinsics;->areEqual(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v3

    if-nez v3, :cond_4

    return v2

    :cond_4
    iget-object v3, p0, Lcom/rokid/security/sdk/base/common/outside/DeviceGbPlatformConfigVO;->sipServerId:Ljava/lang/String;

    iget-object v4, v1, Lcom/rokid/security/sdk/base/common/outside/DeviceGbPlatformConfigVO;->sipServerId:Ljava/lang/String;

    invoke-static {v3, v4}, Lkotlin/jvm/internal/Intrinsics;->areEqual(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v3

    if-nez v3, :cond_5

    return v2

    :cond_5
    iget-object v3, p0, Lcom/rokid/security/sdk/base/common/outside/DeviceGbPlatformConfigVO;->sipServerIp:Ljava/lang/String;

    iget-object v4, v1, Lcom/rokid/security/sdk/base/common/outside/DeviceGbPlatformConfigVO;->sipServerIp:Ljava/lang/String;

    invoke-static {v3, v4}, Lkotlin/jvm/internal/Intrinsics;->areEqual(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v3

    if-nez v3, :cond_6

    return v2

    :cond_6
    iget v3, p0, Lcom/rokid/security/sdk/base/common/outside/DeviceGbPlatformConfigVO;->sipServerPort:I

    iget v4, v1, Lcom/rokid/security/sdk/base/common/outside/DeviceGbPlatformConfigVO;->sipServerPort:I

    if-eq v3, v4, :cond_7

    return v2

    :cond_7
    iget-object v3, p0, Lcom/rokid/security/sdk/base/common/outside/DeviceGbPlatformConfigVO;->transportProtocol:Ljava/lang/String;

    iget-object v4, v1, Lcom/rokid/security/sdk/base/common/outside/DeviceGbPlatformConfigVO;->transportProtocol:Ljava/lang/String;

    invoke-static {v3, v4}, Lkotlin/jvm/internal/Intrinsics;->areEqual(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v3

    if-nez v3, :cond_8

    return v2

    :cond_8
    iget-object v3, p0, Lcom/rokid/security/sdk/base/common/outside/DeviceGbPlatformConfigVO;->domain:Ljava/lang/String;

    iget-object v1, v1, Lcom/rokid/security/sdk/base/common/outside/DeviceGbPlatformConfigVO;->domain:Ljava/lang/String;

    invoke-static {v3, v1}, Lkotlin/jvm/internal/Intrinsics;->areEqual(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v1

    if-nez v1, :cond_9

    return v2

    :cond_9
    return v0
.end method

.method public final getDeviceCode()Ljava/lang/String;
    .locals 1

    .line 23
    iget-object v0, p0, Lcom/rokid/security/sdk/base/common/outside/DeviceGbPlatformConfigVO;->deviceCode:Ljava/lang/String;

    return-object v0
.end method

.method public final getDomain()Ljava/lang/String;
    .locals 1

    .line 37
    iget-object v0, p0, Lcom/rokid/security/sdk/base/common/outside/DeviceGbPlatformConfigVO;->domain:Ljava/lang/String;

    return-object v0
.end method

.method public final getName()Ljava/lang/String;
    .locals 1

    .line 27
    iget-object v0, p0, Lcom/rokid/security/sdk/base/common/outside/DeviceGbPlatformConfigVO;->name:Ljava/lang/String;

    return-object v0
.end method

.method public final getPassword()Ljava/lang/String;
    .locals 1

    .line 25
    iget-object v0, p0, Lcom/rokid/security/sdk/base/common/outside/DeviceGbPlatformConfigVO;->password:Ljava/lang/String;

    return-object v0
.end method

.method public final getSipServerId()Ljava/lang/String;
    .locals 1

    .line 29
    iget-object v0, p0, Lcom/rokid/security/sdk/base/common/outside/DeviceGbPlatformConfigVO;->sipServerId:Ljava/lang/String;

    return-object v0
.end method

.method public final getSipServerIp()Ljava/lang/String;
    .locals 1

    .line 31
    iget-object v0, p0, Lcom/rokid/security/sdk/base/common/outside/DeviceGbPlatformConfigVO;->sipServerIp:Ljava/lang/String;

    return-object v0
.end method

.method public final getSipServerPort()I
    .locals 1

    .line 33
    iget v0, p0, Lcom/rokid/security/sdk/base/common/outside/DeviceGbPlatformConfigVO;->sipServerPort:I

    return v0
.end method

.method public final getTransportProtocol()Ljava/lang/String;
    .locals 1

    .line 35
    iget-object v0, p0, Lcom/rokid/security/sdk/base/common/outside/DeviceGbPlatformConfigVO;->transportProtocol:Ljava/lang/String;

    return-object v0
.end method

.method public hashCode()I
    .locals 4

    iget-object v0, p0, Lcom/rokid/security/sdk/base/common/outside/DeviceGbPlatformConfigVO;->deviceCode:Ljava/lang/String;

    const/4 v1, 0x0

    if-nez v0, :cond_0

    move v0, v1

    goto :goto_0

    :cond_0
    iget-object v0, p0, Lcom/rokid/security/sdk/base/common/outside/DeviceGbPlatformConfigVO;->deviceCode:Ljava/lang/String;

    invoke-virtual {v0}, Ljava/lang/String;->hashCode()I

    move-result v0

    :goto_0
    mul-int/lit8 v2, v0, 0x1f

    iget-object v3, p0, Lcom/rokid/security/sdk/base/common/outside/DeviceGbPlatformConfigVO;->password:Ljava/lang/String;

    if-nez v3, :cond_1

    move v3, v1

    goto :goto_1

    :cond_1
    iget-object v3, p0, Lcom/rokid/security/sdk/base/common/outside/DeviceGbPlatformConfigVO;->password:Ljava/lang/String;

    invoke-virtual {v3}, Ljava/lang/String;->hashCode()I

    move-result v3

    :goto_1
    add-int/2addr v2, v3

    mul-int/lit8 v0, v2, 0x1f

    iget-object v3, p0, Lcom/rokid/security/sdk/base/common/outside/DeviceGbPlatformConfigVO;->name:Ljava/lang/String;

    if-nez v3, :cond_2

    move v3, v1

    goto :goto_2

    :cond_2
    iget-object v3, p0, Lcom/rokid/security/sdk/base/common/outside/DeviceGbPlatformConfigVO;->name:Ljava/lang/String;

    invoke-virtual {v3}, Ljava/lang/String;->hashCode()I

    move-result v3

    :goto_2
    add-int/2addr v0, v3

    mul-int/lit8 v2, v0, 0x1f

    iget-object v3, p0, Lcom/rokid/security/sdk/base/common/outside/DeviceGbPlatformConfigVO;->sipServerId:Ljava/lang/String;

    if-nez v3, :cond_3

    move v3, v1

    goto :goto_3

    :cond_3
    iget-object v3, p0, Lcom/rokid/security/sdk/base/common/outside/DeviceGbPlatformConfigVO;->sipServerId:Ljava/lang/String;

    invoke-virtual {v3}, Ljava/lang/String;->hashCode()I

    move-result v3

    :goto_3
    add-int/2addr v2, v3

    mul-int/lit8 v0, v2, 0x1f

    iget-object v3, p0, Lcom/rokid/security/sdk/base/common/outside/DeviceGbPlatformConfigVO;->sipServerIp:Ljava/lang/String;

    if-nez v3, :cond_4

    move v3, v1

    goto :goto_4

    :cond_4
    iget-object v3, p0, Lcom/rokid/security/sdk/base/common/outside/DeviceGbPlatformConfigVO;->sipServerIp:Ljava/lang/String;

    invoke-virtual {v3}, Ljava/lang/String;->hashCode()I

    move-result v3

    :goto_4
    add-int/2addr v0, v3

    mul-int/lit8 v2, v0, 0x1f

    iget v3, p0, Lcom/rokid/security/sdk/base/common/outside/DeviceGbPlatformConfigVO;->sipServerPort:I

    invoke-static {v3}, Ljava/lang/Integer;->hashCode(I)I

    move-result v3

    add-int/2addr v2, v3

    mul-int/lit8 v0, v2, 0x1f

    iget-object v3, p0, Lcom/rokid/security/sdk/base/common/outside/DeviceGbPlatformConfigVO;->transportProtocol:Ljava/lang/String;

    if-nez v3, :cond_5

    move v3, v1

    goto :goto_5

    :cond_5
    iget-object v3, p0, Lcom/rokid/security/sdk/base/common/outside/DeviceGbPlatformConfigVO;->transportProtocol:Ljava/lang/String;

    invoke-virtual {v3}, Ljava/lang/String;->hashCode()I

    move-result v3

    :goto_5
    add-int/2addr v0, v3

    mul-int/lit8 v2, v0, 0x1f

    iget-object v3, p0, Lcom/rokid/security/sdk/base/common/outside/DeviceGbPlatformConfigVO;->domain:Ljava/lang/String;

    if-nez v3, :cond_6

    goto :goto_6

    :cond_6
    iget-object v1, p0, Lcom/rokid/security/sdk/base/common/outside/DeviceGbPlatformConfigVO;->domain:Ljava/lang/String;

    invoke-virtual {v1}, Ljava/lang/String;->hashCode()I

    move-result v1

    :goto_6
    add-int/2addr v2, v1

    return v2
.end method

.method public final isValid()Z
    .locals 3

    .line 40
    iget-object v0, p0, Lcom/rokid/security/sdk/base/common/outside/DeviceGbPlatformConfigVO;->deviceCode:Ljava/lang/String;

    const-string v1, ""

    if-nez v0, :cond_0

    move-object v0, v1

    :cond_0
    check-cast v0, Ljava/lang/CharSequence;

    invoke-static {v0}, Lkotlin/text/StringsKt;->isBlank(Ljava/lang/CharSequence;)Z

    move-result v0

    const/4 v2, 0x1

    xor-int/2addr v0, v2

    if-eqz v0, :cond_6

    .line 41
    iget-object v0, p0, Lcom/rokid/security/sdk/base/common/outside/DeviceGbPlatformConfigVO;->name:Ljava/lang/String;

    if-nez v0, :cond_1

    move-object v0, v1

    :cond_1
    check-cast v0, Ljava/lang/CharSequence;

    invoke-static {v0}, Lkotlin/text/StringsKt;->isBlank(Ljava/lang/CharSequence;)Z

    move-result v0

    xor-int/2addr v0, v2

    if-eqz v0, :cond_6

    .line 42
    iget-object v0, p0, Lcom/rokid/security/sdk/base/common/outside/DeviceGbPlatformConfigVO;->sipServerId:Ljava/lang/String;

    if-nez v0, :cond_2

    move-object v0, v1

    :cond_2
    check-cast v0, Ljava/lang/CharSequence;

    invoke-static {v0}, Lkotlin/text/StringsKt;->isBlank(Ljava/lang/CharSequence;)Z

    move-result v0

    xor-int/2addr v0, v2

    if-eqz v0, :cond_6

    .line 43
    iget-object v0, p0, Lcom/rokid/security/sdk/base/common/outside/DeviceGbPlatformConfigVO;->sipServerIp:Ljava/lang/String;

    if-nez v0, :cond_3

    move-object v0, v1

    :cond_3
    check-cast v0, Ljava/lang/CharSequence;

    invoke-static {v0}, Lkotlin/text/StringsKt;->isBlank(Ljava/lang/CharSequence;)Z

    move-result v0

    xor-int/2addr v0, v2

    if-eqz v0, :cond_6

    .line 44
    iget-object v0, p0, Lcom/rokid/security/sdk/base/common/outside/DeviceGbPlatformConfigVO;->transportProtocol:Ljava/lang/String;

    if-nez v0, :cond_4

    move-object v0, v1

    :cond_4
    check-cast v0, Ljava/lang/CharSequence;

    invoke-static {v0}, Lkotlin/text/StringsKt;->isBlank(Ljava/lang/CharSequence;)Z

    move-result v0

    xor-int/2addr v0, v2

    if-eqz v0, :cond_6

    .line 45
    iget-object v0, p0, Lcom/rokid/security/sdk/base/common/outside/DeviceGbPlatformConfigVO;->domain:Ljava/lang/String;

    if-nez v0, :cond_5

    goto :goto_0

    :cond_5
    move-object v1, v0

    :goto_0
    check-cast v1, Ljava/lang/CharSequence;

    invoke-static {v1}, Lkotlin/text/StringsKt;->isBlank(Ljava/lang/CharSequence;)Z

    move-result v0

    xor-int/2addr v0, v2

    if-eqz v0, :cond_6

    .line 46
    iget v0, p0, Lcom/rokid/security/sdk/base/common/outside/DeviceGbPlatformConfigVO;->sipServerPort:I

    if-lez v0, :cond_6

    goto :goto_1

    :cond_6
    const/4 v2, 0x0

    .line 40
    :goto_1
    return v2
.end method

.method public final toConfigFingerprint()I
    .locals 10

    .line 65
    const/16 v0, 0x8

    new-array v0, v0, [Ljava/lang/String;

    iget-object v1, p0, Lcom/rokid/security/sdk/base/common/outside/DeviceGbPlatformConfigVO;->deviceCode:Ljava/lang/String;

    const-string v2, ""

    if-nez v1, :cond_0

    move-object v1, v2

    :cond_0
    const/4 v3, 0x0

    aput-object v1, v0, v3

    .line 66
    iget-object v1, p0, Lcom/rokid/security/sdk/base/common/outside/DeviceGbPlatformConfigVO;->password:Ljava/lang/String;

    if-nez v1, :cond_1

    move-object v1, v2

    :cond_1
    const/4 v3, 0x1

    aput-object v1, v0, v3

    .line 65
    nop

    .line 67
    iget-object v1, p0, Lcom/rokid/security/sdk/base/common/outside/DeviceGbPlatformConfigVO;->name:Ljava/lang/String;

    if-nez v1, :cond_2

    move-object v1, v2

    :cond_2
    const/4 v3, 0x2

    aput-object v1, v0, v3

    .line 65
    nop

    .line 68
    iget-object v1, p0, Lcom/rokid/security/sdk/base/common/outside/DeviceGbPlatformConfigVO;->sipServerId:Ljava/lang/String;

    if-nez v1, :cond_3

    move-object v1, v2

    :cond_3
    const/4 v3, 0x3

    aput-object v1, v0, v3

    .line 65
    nop

    .line 69
    iget-object v1, p0, Lcom/rokid/security/sdk/base/common/outside/DeviceGbPlatformConfigVO;->sipServerIp:Ljava/lang/String;

    if-nez v1, :cond_4

    move-object v1, v2

    :cond_4
    const/4 v3, 0x4

    aput-object v1, v0, v3

    .line 65
    nop

    .line 70
    iget v1, p0, Lcom/rokid/security/sdk/base/common/outside/DeviceGbPlatformConfigVO;->sipServerPort:I

    invoke-static {v1}, Ljava/lang/String;->valueOf(I)Ljava/lang/String;

    move-result-object v1

    const/4 v3, 0x5

    aput-object v1, v0, v3

    .line 65
    nop

    .line 71
    iget-object v1, p0, Lcom/rokid/security/sdk/base/common/outside/DeviceGbPlatformConfigVO;->transportProtocol:Ljava/lang/String;

    if-nez v1, :cond_5

    move-object v1, v2

    :cond_5
    sget-object v3, Ljava/util/Locale;->ROOT:Ljava/util/Locale;

    invoke-virtual {v1, v3}, Ljava/lang/String;->toUpperCase(Ljava/util/Locale;)Ljava/lang/String;

    move-result-object v1

    const-string/jumbo v3, "this as java.lang.String).toUpperCase(Locale.ROOT)"

    invoke-static {v1, v3}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    const/4 v3, 0x6

    aput-object v1, v0, v3

    .line 65
    nop

    .line 72
    iget-object v1, p0, Lcom/rokid/security/sdk/base/common/outside/DeviceGbPlatformConfigVO;->domain:Ljava/lang/String;

    if-nez v1, :cond_6

    goto :goto_0

    :cond_6
    move-object v2, v1

    :goto_0
    const/4 v1, 0x7

    aput-object v2, v0, v1

    .line 65
    nop

    .line 64
    invoke-static {v0}, Lkotlin/collections/CollectionsKt;->listOf([Ljava/lang/Object;)Ljava/util/List;

    move-result-object v0

    move-object v1, v0

    check-cast v1, Ljava/lang/Iterable;

    .line 73
    const-string/jumbo v0, "|"

    move-object v2, v0

    check-cast v2, Ljava/lang/CharSequence;

    const/16 v8, 0x3e

    const/4 v9, 0x0

    const/4 v3, 0x0

    const/4 v4, 0x0

    const/4 v5, 0x0

    const/4 v6, 0x0

    const/4 v7, 0x0

    invoke-static/range {v1 .. v9}, Lkotlin/collections/CollectionsKt;->joinToString$default(Ljava/lang/Iterable;Ljava/lang/CharSequence;Ljava/lang/CharSequence;Ljava/lang/CharSequence;ILjava/lang/CharSequence;Lkotlin/jvm/functions/Function1;ILjava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/String;->hashCode()I

    move-result v0

    const v1, 0x7fffffff

    and-int/2addr v0, v1

    .line 64
    return v0
.end method

.method public toString()Ljava/lang/String;
    .locals 2

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "DeviceGbPlatformConfigVO(deviceCode="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-object v1, p0, Lcom/rokid/security/sdk/base/common/outside/DeviceGbPlatformConfigVO;->deviceCode:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, ", password="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-object v1, p0, Lcom/rokid/security/sdk/base/common/outside/DeviceGbPlatformConfigVO;->password:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, ", name="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-object v1, p0, Lcom/rokid/security/sdk/base/common/outside/DeviceGbPlatformConfigVO;->name:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, ", sipServerId="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-object v1, p0, Lcom/rokid/security/sdk/base/common/outside/DeviceGbPlatformConfigVO;->sipServerId:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, ", sipServerIp="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-object v1, p0, Lcom/rokid/security/sdk/base/common/outside/DeviceGbPlatformConfigVO;->sipServerIp:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, ", sipServerPort="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget v1, p0, Lcom/rokid/security/sdk/base/common/outside/DeviceGbPlatformConfigVO;->sipServerPort:I

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, ", transportProtocol="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-object v1, p0, Lcom/rokid/security/sdk/base/common/outside/DeviceGbPlatformConfigVO;->transportProtocol:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, ", domain="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-object v1, p0, Lcom/rokid/security/sdk/base/common/outside/DeviceGbPlatformConfigVO;->domain:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const/16 v1, 0x29

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public final toSyncConfig(I)Lcom/rokid/security/sdk/base/common/outside/GB28181SyncConfig;
    .locals 11
    .param p1, "configFingerprint"    # I

    .line 50
    new-instance v10, Lcom/rokid/security/sdk/base/common/outside/GB28181SyncConfig;

    .line 51
    iget-object v0, p0, Lcom/rokid/security/sdk/base/common/outside/DeviceGbPlatformConfigVO;->deviceCode:Ljava/lang/String;

    const-string v1, ""

    if-nez v0, :cond_0

    move-object v2, v1

    goto :goto_0

    :cond_0
    move-object v2, v0

    .line 52
    :goto_0
    iget-object v0, p0, Lcom/rokid/security/sdk/base/common/outside/DeviceGbPlatformConfigVO;->password:Ljava/lang/String;

    if-nez v0, :cond_1

    move-object v3, v1

    goto :goto_1

    :cond_1
    move-object v3, v0

    .line 53
    :goto_1
    iget-object v0, p0, Lcom/rokid/security/sdk/base/common/outside/DeviceGbPlatformConfigVO;->domain:Ljava/lang/String;

    if-nez v0, :cond_2

    move-object v4, v1

    goto :goto_2

    :cond_2
    move-object v4, v0

    .line 54
    :goto_2
    iget-object v0, p0, Lcom/rokid/security/sdk/base/common/outside/DeviceGbPlatformConfigVO;->sipServerIp:Ljava/lang/String;

    if-nez v0, :cond_3

    move-object v5, v1

    goto :goto_3

    :cond_3
    move-object v5, v0

    .line 55
    :goto_3
    iget-object v0, p0, Lcom/rokid/security/sdk/base/common/outside/DeviceGbPlatformConfigVO;->sipServerId:Ljava/lang/String;

    if-nez v0, :cond_4

    move-object v6, v1

    goto :goto_4

    :cond_4
    move-object v6, v0

    .line 56
    :goto_4
    iget v0, p0, Lcom/rokid/security/sdk/base/common/outside/DeviceGbPlatformConfigVO;->sipServerPort:I

    invoke-static {v0}, Ljava/lang/String;->valueOf(I)Ljava/lang/String;

    move-result-object v7

    .line 57
    iget-object v0, p0, Lcom/rokid/security/sdk/base/common/outside/DeviceGbPlatformConfigVO;->transportProtocol:Ljava/lang/String;

    if-nez v0, :cond_5

    move-object v0, v1

    :cond_5
    sget-object v8, Ljava/util/Locale;->ROOT:Ljava/util/Locale;

    invoke-virtual {v0, v8}, Ljava/lang/String;->toUpperCase(Ljava/util/Locale;)Ljava/lang/String;

    move-result-object v8

    const-string/jumbo v0, "this as java.lang.String).toUpperCase(Locale.ROOT)"

    invoke-static {v8, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    .line 58
    iget-object v0, p0, Lcom/rokid/security/sdk/base/common/outside/DeviceGbPlatformConfigVO;->name:Ljava/lang/String;

    if-nez v0, :cond_6

    move-object v9, v1

    goto :goto_5

    :cond_6
    move-object v9, v0

    .line 59
    :goto_5
    nop

    .line 50
    move-object v0, v10

    move-object v1, v2

    move-object v2, v3

    move-object v3, v4

    move-object v4, v5

    move-object v5, v6

    move-object v6, v7

    move-object v7, v8

    move-object v8, v9

    move v9, p1

    invoke-direct/range {v0 .. v9}, Lcom/rokid/security/sdk/base/common/outside/GB28181SyncConfig;-><init>(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;I)V

    return-object v10
.end method
