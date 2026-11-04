.class public final Lcom/rokid/security/sdk/base/common/SyncTimeExtra;
.super Ljava/lang/Object;
.source "ToolsExtra.kt"


# annotations
.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000\u001c\n\u0002\u0018\u0002\n\u0002\u0010\u0000\n\u0002\u0008\u0002\n\u0002\u0010\u000e\n\u0002\u0008\u0008\n\u0002\u0010\t\n\u0002\u0008\u0005\u0018\u00002\u00020\u0001B\u0005\u00a2\u0006\u0002\u0010\u0002R\u001a\u0010\u0003\u001a\u00020\u0004X\u0086\u000e\u00a2\u0006\u000e\n\u0000\u001a\u0004\u0008\u0005\u0010\u0006\"\u0004\u0008\u0007\u0010\u0008R\u001a\u0010\t\u001a\u00020\u0004X\u0086\u000e\u00a2\u0006\u000e\n\u0000\u001a\u0004\u0008\n\u0010\u0006\"\u0004\u0008\u000b\u0010\u0008R\u001a\u0010\u000c\u001a\u00020\rX\u0086\u000e\u00a2\u0006\u000e\n\u0000\u001a\u0004\u0008\u000e\u0010\u000f\"\u0004\u0008\u0010\u0010\u0011\u00a8\u0006\u0012"
    }
    d2 = {
        "Lcom/rokid/security/sdk/base/common/SyncTimeExtra;",
        "",
        "()V",
        "extraType",
        "",
        "getExtraType",
        "()Ljava/lang/String;",
        "setExtraType",
        "(Ljava/lang/String;)V",
        "methodName",
        "getMethodName",
        "setMethodName",
        "time",
        "",
        "getTime",
        "()J",
        "setTime",
        "(J)V",
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
.field private extraType:Ljava/lang/String;

.field private methodName:Ljava/lang/String;

.field private time:J


# direct methods
.method public constructor <init>()V
    .locals 1

    .line 11
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 12
    const-string v0, "SYNC_TIME"

    iput-object v0, p0, Lcom/rokid/security/sdk/base/common/SyncTimeExtra;->extraType:Ljava/lang/String;

    .line 13
    const-string v0, ""

    iput-object v0, p0, Lcom/rokid/security/sdk/base/common/SyncTimeExtra;->methodName:Ljava/lang/String;

    .line 11
    return-void
.end method


# virtual methods
.method public final getExtraType()Ljava/lang/String;
    .locals 1

    .line 12
    iget-object v0, p0, Lcom/rokid/security/sdk/base/common/SyncTimeExtra;->extraType:Ljava/lang/String;

    return-object v0
.end method

.method public final getMethodName()Ljava/lang/String;
    .locals 1

    .line 13
    iget-object v0, p0, Lcom/rokid/security/sdk/base/common/SyncTimeExtra;->methodName:Ljava/lang/String;

    return-object v0
.end method

.method public final getTime()J
    .locals 2

    .line 14
    iget-wide v0, p0, Lcom/rokid/security/sdk/base/common/SyncTimeExtra;->time:J

    return-wide v0
.end method

.method public final setExtraType(Ljava/lang/String;)V
    .locals 1
    .param p1, "<set-?>"    # Ljava/lang/String;

    const-string v0, "<set-?>"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 12
    iput-object p1, p0, Lcom/rokid/security/sdk/base/common/SyncTimeExtra;->extraType:Ljava/lang/String;

    return-void
.end method

.method public final setMethodName(Ljava/lang/String;)V
    .locals 1
    .param p1, "<set-?>"    # Ljava/lang/String;

    const-string v0, "<set-?>"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 13
    iput-object p1, p0, Lcom/rokid/security/sdk/base/common/SyncTimeExtra;->methodName:Ljava/lang/String;

    return-void
.end method

.method public final setTime(J)V
    .locals 0
    .param p1, "<set-?>"    # J

    .line 14
    iput-wide p1, p0, Lcom/rokid/security/sdk/base/common/SyncTimeExtra;->time:J

    return-void
.end method
