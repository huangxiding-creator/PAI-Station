.class public final Lcom/rokid/security/phone/sdk/server/engine/WsServiceInit;
.super Ljava/lang/Object;
.source "WsServiceInit.kt"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/rokid/security/phone/sdk/server/engine/WsServiceInit$InitStatus;
    }
.end annotation

.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000\u001c\n\u0002\u0018\u0002\n\u0002\u0010\u0000\n\u0002\u0008\u0002\n\u0002\u0010%\n\u0002\u0018\u0002\n\u0002\u0018\u0002\n\u0002\u0008\u0006\u0008\u00c6\u0002\u0018\u00002\u00020\u0001:\u0001\u000bB\u0007\u0008\u0002\u00a2\u0006\u0002\u0010\u0002R&\u0010\u0003\u001a\u000e\u0012\u0004\u0012\u00020\u0005\u0012\u0004\u0012\u00020\u00060\u0004X\u0086\u000e\u00a2\u0006\u000e\n\u0000\u001a\u0004\u0008\u0007\u0010\u0008\"\u0004\u0008\t\u0010\n\u00a8\u0006\u000c"
    }
    d2 = {
        "Lcom/rokid/security/phone/sdk/server/engine/WsServiceInit;",
        "",
        "()V",
        "WsServiceInitMap",
        "",
        "Lcom/rokid/security/phone/sdk/base/data/NetServiceType;",
        "Lcom/rokid/security/phone/sdk/server/engine/WsServiceInit$InitStatus;",
        "getWsServiceInitMap",
        "()Ljava/util/Map;",
        "setWsServiceInitMap",
        "(Ljava/util/Map;)V",
        "InitStatus",
        "sdk-server_release"
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
.field public static final INSTANCE:Lcom/rokid/security/phone/sdk/server/engine/WsServiceInit;

.field private static WsServiceInitMap:Ljava/util/Map;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/Map<",
            "Lcom/rokid/security/phone/sdk/base/data/NetServiceType;",
            "Lcom/rokid/security/phone/sdk/server/engine/WsServiceInit$InitStatus;",
            ">;"
        }
    .end annotation
.end field


# direct methods
.method static constructor <clinit>()V
    .locals 1

    new-instance v0, Lcom/rokid/security/phone/sdk/server/engine/WsServiceInit;

    invoke-direct {v0}, Lcom/rokid/security/phone/sdk/server/engine/WsServiceInit;-><init>()V

    sput-object v0, Lcom/rokid/security/phone/sdk/server/engine/WsServiceInit;->INSTANCE:Lcom/rokid/security/phone/sdk/server/engine/WsServiceInit;

    .line 11
    new-instance v0, Ljava/util/LinkedHashMap;

    invoke-direct {v0}, Ljava/util/LinkedHashMap;-><init>()V

    check-cast v0, Ljava/util/Map;

    sput-object v0, Lcom/rokid/security/phone/sdk/server/engine/WsServiceInit;->WsServiceInitMap:Ljava/util/Map;

    return-void
.end method

.method private constructor <init>()V
    .locals 0

    .line 9
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public final getWsServiceInitMap()Ljava/util/Map;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/Map<",
            "Lcom/rokid/security/phone/sdk/base/data/NetServiceType;",
            "Lcom/rokid/security/phone/sdk/server/engine/WsServiceInit$InitStatus;",
            ">;"
        }
    .end annotation

    .line 11
    sget-object v0, Lcom/rokid/security/phone/sdk/server/engine/WsServiceInit;->WsServiceInitMap:Ljava/util/Map;

    return-object v0
.end method

.method public final setWsServiceInitMap(Ljava/util/Map;)V
    .locals 1
    .param p1, "<set-?>"    # Ljava/util/Map;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/Map<",
            "Lcom/rokid/security/phone/sdk/base/data/NetServiceType;",
            "Lcom/rokid/security/phone/sdk/server/engine/WsServiceInit$InitStatus;",
            ">;)V"
        }
    .end annotation

    const-string v0, "<set-?>"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 11
    sput-object p1, Lcom/rokid/security/phone/sdk/server/engine/WsServiceInit;->WsServiceInitMap:Ljava/util/Map;

    return-void
.end method
