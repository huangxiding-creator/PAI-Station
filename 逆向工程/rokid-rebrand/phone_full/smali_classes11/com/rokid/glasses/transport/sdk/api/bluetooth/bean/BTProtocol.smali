.class public final Lcom/rokid/glasses/transport/sdk/api/bluetooth/bean/BTProtocol;
.super Ljava/lang/Object;
.source "BTProtocol.kt"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/rokid/glasses/transport/sdk/api/bluetooth/bean/BTProtocol$Message;
    }
.end annotation

.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000\u000c\n\u0002\u0018\u0002\n\u0002\u0010\u0000\n\u0002\u0008\u0003\u0008\u00c6\u0002\u0018\u00002\u00020\u0001:\u0001\u0003B\u0007\u0008\u0002\u00a2\u0006\u0002\u0010\u0002\u00a8\u0006\u0004"
    }
    d2 = {
        "Lcom/rokid/glasses/transport/sdk/api/bluetooth/bean/BTProtocol;",
        "",
        "()V",
        "Message",
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
.field public static final INSTANCE:Lcom/rokid/glasses/transport/sdk/api/bluetooth/bean/BTProtocol;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    new-instance v0, Lcom/rokid/glasses/transport/sdk/api/bluetooth/bean/BTProtocol;

    invoke-direct {v0}, Lcom/rokid/glasses/transport/sdk/api/bluetooth/bean/BTProtocol;-><init>()V

    sput-object v0, Lcom/rokid/glasses/transport/sdk/api/bluetooth/bean/BTProtocol;->INSTANCE:Lcom/rokid/glasses/transport/sdk/api/bluetooth/bean/BTProtocol;

    return-void
.end method

.method private constructor <init>()V
    .locals 0

    .line 6
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method
