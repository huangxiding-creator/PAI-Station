.class public final Lcom/rokid/security/sdk/base/common/outside/FaceByte;
.super Ljava/lang/Object;
.source "VehicleInfo.kt"


# annotations
.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000\u0018\n\u0002\u0018\u0002\n\u0002\u0010\u0000\n\u0000\n\u0002\u0010\u000e\n\u0000\n\u0002\u0010\u0012\n\u0002\u0008\u0006\u0018\u00002\u00020\u0001B\u0015\u0012\u0006\u0010\u0002\u001a\u00020\u0003\u0012\u0006\u0010\u0004\u001a\u00020\u0005\u00a2\u0006\u0002\u0010\u0006R\u0011\u0010\u0004\u001a\u00020\u0005\u00a2\u0006\u0008\n\u0000\u001a\u0004\u0008\u0007\u0010\u0008R\u0011\u0010\u0002\u001a\u00020\u0003\u00a2\u0006\u0008\n\u0000\u001a\u0004\u0008\t\u0010\n\u00a8\u0006\u000b"
    }
    d2 = {
        "Lcom/rokid/security/sdk/base/common/outside/FaceByte;",
        "",
        "tag",
        "",
        "dataList",
        "",
        "(Ljava/lang/String;[B)V",
        "getDataList",
        "()[B",
        "getTag",
        "()Ljava/lang/String;",
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
.field private final dataList:[B

.field private final tag:Ljava/lang/String;


# direct methods
.method public constructor <init>(Ljava/lang/String;[B)V
    .locals 1
    .param p1, "tag"    # Ljava/lang/String;
    .param p2, "dataList"    # [B

    const-string/jumbo v0, "tag"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    const-string v0, "dataList"

    invoke-static {p2, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 154
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 155
    iput-object p1, p0, Lcom/rokid/security/sdk/base/common/outside/FaceByte;->tag:Ljava/lang/String;

    .line 156
    iput-object p2, p0, Lcom/rokid/security/sdk/base/common/outside/FaceByte;->dataList:[B

    .line 154
    return-void
.end method


# virtual methods
.method public final getDataList()[B
    .locals 1

    .line 156
    iget-object v0, p0, Lcom/rokid/security/sdk/base/common/outside/FaceByte;->dataList:[B

    return-object v0
.end method

.method public final getTag()Ljava/lang/String;
    .locals 1

    .line 155
    iget-object v0, p0, Lcom/rokid/security/sdk/base/common/outside/FaceByte;->tag:Ljava/lang/String;

    return-object v0
.end method
