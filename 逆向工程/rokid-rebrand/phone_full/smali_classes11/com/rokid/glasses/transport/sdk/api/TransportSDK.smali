.class public final Lcom/rokid/glasses/transport/sdk/api/TransportSDK;
.super Ljava/lang/Object;
.source "TransportSDK.kt"


# annotations
.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000<\n\u0002\u0018\u0002\n\u0002\u0010\u0000\n\u0002\u0008\u0002\n\u0002\u0010\u0002\n\u0000\n\u0002\u0018\u0002\n\u0002\u0008\u0002\n\u0002\u0010\u000b\n\u0000\n\u0002\u0010\u000e\n\u0000\n\u0002\u0010\u0008\n\u0000\n\u0002\u0018\u0002\n\u0002\u0018\u0002\n\u0002\u0018\u0002\n\u0002\u0008\u0003\u0008\u00c6\u0002\u0018\u00002\u00020\u0001B\u0007\u0008\u0002\u00a2\u0006\u0002\u0010\u0002J\u0008\u0010\u0003\u001a\u00020\u0004H\u0007J\u0008\u0010\u0005\u001a\u00020\u0006H\u0007JN\u0010\u0007\u001a\u00020\u00042\u0006\u0010\u0008\u001a\u00020\t2\u0008\u0008\u0002\u0010\n\u001a\u00020\u000b2\u0006\u0010\u000c\u001a\u00020\r2\'\u0010\u000e\u001a#\u0012\u0019\u0012\u0017\u0012\u0004\u0012\u00020\t0\u0010\u00a2\u0006\u000c\u0008\u0011\u0012\u0008\u0008\u0012\u0012\u0004\u0008\u0008(\u0013\u0012\u0004\u0012\u00020\u00040\u000fH\u0007\u00f8\u0001\u0000\u0082\u0002\u0004\n\u0002\u0008\u0019\u00a8\u0006\u0014"
    }
    d2 = {
        "Lcom/rokid/glasses/transport/sdk/api/TransportSDK;",
        "",
        "()V",
        "destroy",
        "",
        "getGlassesEngineService",
        "Lcom/rokid/glasses/transport/sdk/api/engine/api/AbsGlassesEngineService;",
        "initSDK",
        "isGroupOwner",
        "",
        "ownerId",
        "",
        "port",
        "",
        "onResult",
        "Lkotlin/Function1;",
        "Lcom/rokid/glasses/transport/sdk/api/callback/IResult;",
        "Lkotlin/ParameterName;",
        "name",
        "result",
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
.field public static final INSTANCE:Lcom/rokid/glasses/transport/sdk/api/TransportSDK;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    new-instance v0, Lcom/rokid/glasses/transport/sdk/api/TransportSDK;

    invoke-direct {v0}, Lcom/rokid/glasses/transport/sdk/api/TransportSDK;-><init>()V

    sput-object v0, Lcom/rokid/glasses/transport/sdk/api/TransportSDK;->INSTANCE:Lcom/rokid/glasses/transport/sdk/api/TransportSDK;

    return-void
.end method

.method private constructor <init>()V
    .locals 0

    .line 8
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static final destroy()V
    .locals 1
    .annotation runtime Lkotlin/jvm/JvmStatic;
    .end annotation

    .line 37
    invoke-static {}, Lcom/rokid/glasses/transport/sdk/api/TransportSDK;->getGlassesEngineService()Lcom/rokid/glasses/transport/sdk/api/engine/api/AbsGlassesEngineService;

    move-result-object v0

    invoke-virtual {v0}, Lcom/rokid/glasses/transport/sdk/api/engine/api/AbsGlassesEngineService;->destroy()V

    .line 38
    return-void
.end method

.method public static final getGlassesEngineService()Lcom/rokid/glasses/transport/sdk/api/engine/api/AbsGlassesEngineService;
    .locals 1
    .annotation runtime Lkotlin/jvm/JvmStatic;
    .end annotation

    const-class v0, Lcom/rokid/glasses/transport/sdk/api/engine/api/AbsGlassesEngineService;

    .line 32
    invoke-static {v0}, Lcom/rokid/glasses/transport/sdk/api/utils/ServiceManager;->getService(Ljava/lang/Class;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/rokid/glasses/transport/sdk/api/engine/api/AbsGlassesEngineService;

    return-object v0
.end method

.method public static final initSDK(ZLjava/lang/String;ILkotlin/jvm/functions/Function1;)V
    .locals 1
    .param p0, "isGroupOwner"    # Z
    .param p1, "ownerId"    # Ljava/lang/String;
    .param p2, "port"    # I
    .param p3, "onResult"    # Lkotlin/jvm/functions/Function1;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(Z",
            "Ljava/lang/String;",
            "I",
            "Lkotlin/jvm/functions/Function1<",
            "-",
            "Lcom/rokid/glasses/transport/sdk/api/callback/IResult<",
            "Ljava/lang/Boolean;",
            ">;",
            "Lkotlin/Unit;",
            ">;)V"
        }
    .end annotation

    .annotation runtime Lkotlin/jvm/JvmStatic;
    .end annotation

    const-string v0, "ownerId"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    const-string v0, "onResult"

    invoke-static {p3, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 23
    invoke-static {}, Lcom/rokid/glasses/transport/sdk/api/TransportSDK;->getGlassesEngineService()Lcom/rokid/glasses/transport/sdk/api/engine/api/AbsGlassesEngineService;

    move-result-object v0

    .line 24
    invoke-virtual {v0, p0, p1, p2, p3}, Lcom/rokid/glasses/transport/sdk/api/engine/api/AbsGlassesEngineService;->initSDK(ZLjava/lang/String;ILkotlin/jvm/functions/Function1;)V

    .line 25
    return-void
.end method

.method public static synthetic initSDK$default(ZLjava/lang/String;ILkotlin/jvm/functions/Function1;ILjava/lang/Object;)V
    .locals 0

    .line 17
    and-int/lit8 p4, p4, 0x2

    if-eqz p4, :cond_0

    .line 19
    const-string p1, ""

    .line 17
    :cond_0
    invoke-static {p0, p1, p2, p3}, Lcom/rokid/glasses/transport/sdk/api/TransportSDK;->initSDK(ZLjava/lang/String;ILkotlin/jvm/functions/Function1;)V

    return-void
.end method
