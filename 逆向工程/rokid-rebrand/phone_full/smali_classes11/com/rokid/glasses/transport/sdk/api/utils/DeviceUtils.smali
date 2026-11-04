.class public final Lcom/rokid/glasses/transport/sdk/api/utils/DeviceUtils;
.super Ljava/lang/Object;
.source "DeviceUtils.kt"


# annotations
.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000\u001a\n\u0002\u0018\u0002\n\u0002\u0010\u0000\n\u0002\u0008\u0002\n\u0002\u0010\u000e\n\u0000\n\u0002\u0010\u0008\n\u0002\u0008\u0003\u0008\u00c6\u0002\u0018\u00002\u00020\u0001B\u0007\u0008\u0002\u00a2\u0006\u0002\u0010\u0002J\u000e\u0010\u0003\u001a\u00020\u00042\u0006\u0010\u0005\u001a\u00020\u0006J\u000e\u0010\u0007\u001a\u00020\u00042\u0006\u0010\u0008\u001a\u00020\u0006\u00a8\u0006\t"
    }
    d2 = {
        "Lcom/rokid/glasses/transport/sdk/api/utils/DeviceUtils;",
        "",
        "()V",
        "getBleDeviceStatus",
        "",
        "connectionState",
        "",
        "getP2PDeviceStatus",
        "deviceStatus",
        "sdk-api_release"
    }
    k = 0x1
    mv = {
        0x1,
        0x8,
        0x0
    }
    xi = 0x30
.end annotation


# static fields
.field public static final INSTANCE:Lcom/rokid/glasses/transport/sdk/api/utils/DeviceUtils;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    new-instance v0, Lcom/rokid/glasses/transport/sdk/api/utils/DeviceUtils;

    invoke-direct {v0}, Lcom/rokid/glasses/transport/sdk/api/utils/DeviceUtils;-><init>()V

    sput-object v0, Lcom/rokid/glasses/transport/sdk/api/utils/DeviceUtils;->INSTANCE:Lcom/rokid/glasses/transport/sdk/api/utils/DeviceUtils;

    return-void
.end method

.method private constructor <init>()V
    .locals 0

    .line 6
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public final getBleDeviceStatus(I)Ljava/lang/String;
    .locals 1
    .param p1, "connectionState"    # I

    .line 20
    packed-switch p1, :pswitch_data_0

    .line 25
    const-string v0, "\u672a\u77e5\u72b6\u6001"

    goto :goto_0

    .line 24
    :pswitch_0
    const-string v0, "\u65ad\u5f00\u4e2d"

    goto :goto_0

    .line 23
    :pswitch_1
    const-string v0, "\u5df2\u8fde\u63a5"

    goto :goto_0

    .line 22
    :pswitch_2
    const-string v0, "\u8fde\u63a5\u4e2d"

    goto :goto_0

    .line 21
    :pswitch_3
    const-string v0, "\u672a\u8fde\u63a5"

    .line 20
    :goto_0
    return-object v0

    :pswitch_data_0
    .packed-switch 0x0
        :pswitch_3
        :pswitch_2
        :pswitch_1
        :pswitch_0
    .end packed-switch
.end method

.method public final getP2PDeviceStatus(I)Ljava/lang/String;
    .locals 1
    .param p1, "deviceStatus"    # I

    .line 9
    packed-switch p1, :pswitch_data_0

    .line 15
    const-string v0, "\u672a\u77e5"

    goto :goto_0

    .line 14
    :pswitch_0
    const-string v0, "\u4e0d\u53ef\u7528\u7684"

    goto :goto_0

    .line 10
    :pswitch_1
    const-string v0, "\u53ef\u7528\u7684"

    goto :goto_0

    .line 13
    :pswitch_2
    const-string v0, "\u5931\u8d25\u7684"

    goto :goto_0

    .line 11
    :pswitch_3
    const-string v0, "\u9080\u8bf7\u4e2d"

    goto :goto_0

    .line 12
    :pswitch_4
    const-string v0, "\u5df2\u8fde\u63a5"

    .line 9
    :goto_0
    return-object v0

    nop

    :pswitch_data_0
    .packed-switch 0x0
        :pswitch_4
        :pswitch_3
        :pswitch_2
        :pswitch_1
        :pswitch_0
    .end packed-switch
.end method
