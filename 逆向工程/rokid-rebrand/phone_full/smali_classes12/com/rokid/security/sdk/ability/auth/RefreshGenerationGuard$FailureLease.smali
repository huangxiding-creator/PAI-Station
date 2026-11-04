.class public final Lcom/rokid/security/sdk/ability/auth/RefreshGenerationGuard$FailureLease;
.super Ljava/lang/Object;
.source "RefreshGenerationGuard.kt"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/rokid/security/sdk/ability/auth/RefreshGenerationGuard;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x19
    name = "FailureLease"
.end annotation

.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000\u0012\n\u0002\u0018\u0002\n\u0002\u0010\u0000\n\u0000\n\u0002\u0010\t\n\u0002\u0008\u0004\u0018\u00002\u00020\u0001B\u000f\u0008\u0000\u0012\u0006\u0010\u0002\u001a\u00020\u0003\u00a2\u0006\u0002\u0010\u0004R\u0011\u0010\u0002\u001a\u00020\u0003\u00a2\u0006\u0008\n\u0000\u001a\u0004\u0008\u0005\u0010\u0006\u00a8\u0006\u0007"
    }
    d2 = {
        "Lcom/rokid/security/sdk/ability/auth/RefreshGenerationGuard$FailureLease;",
        "",
        "generation",
        "",
        "(J)V",
        "getGeneration",
        "()J",
        "sdk-common-ability_release"
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
.field private final generation:J


# direct methods
.method public constructor <init>(J)V
    .locals 0
    .param p1, "generation"    # J

    .line 13
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 14
    iput-wide p1, p0, Lcom/rokid/security/sdk/ability/auth/RefreshGenerationGuard$FailureLease;->generation:J

    .line 13
    return-void
.end method


# virtual methods
.method public final getGeneration()J
    .locals 2

    .line 14
    iget-wide v0, p0, Lcom/rokid/security/sdk/ability/auth/RefreshGenerationGuard$FailureLease;->generation:J

    return-wide v0
.end method
