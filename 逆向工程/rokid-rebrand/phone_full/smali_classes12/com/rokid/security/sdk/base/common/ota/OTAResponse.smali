.class public final Lcom/rokid/security/sdk/base/common/ota/OTAResponse;
.super Ljava/lang/Object;
.source "SystemResponse.kt"


# annotations
.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000\u001c\n\u0002\u0018\u0002\n\u0002\u0010\u0000\n\u0002\u0008\u0002\n\u0002\u0018\u0002\n\u0002\u0008\u0005\n\u0002\u0010\u000b\n\u0002\u0008\u0005\u0018\u00002\u00020\u0001B\u0005\u00a2\u0006\u0002\u0010\u0002R \u0010\u0003\u001a\u0004\u0018\u00010\u00048\u0006@\u0006X\u0087\u000e\u00a2\u0006\u000e\n\u0000\u001a\u0004\u0008\u0005\u0010\u0006\"\u0004\u0008\u0007\u0010\u0008R\u001e\u0010\t\u001a\u00020\n8\u0006@\u0006X\u0087\u000e\u00a2\u0006\u000e\n\u0000\u001a\u0004\u0008\u000b\u0010\u000c\"\u0004\u0008\r\u0010\u000e\u00a8\u0006\u000f"
    }
    d2 = {
        "Lcom/rokid/security/sdk/base/common/ota/OTAResponse;",
        "",
        "()V",
        "data",
        "Lcom/rokid/security/sdk/base/common/ota/SystemResponse;",
        "getData",
        "()Lcom/rokid/security/sdk/base/common/ota/SystemResponse;",
        "setData",
        "(Lcom/rokid/security/sdk/base/common/ota/SystemResponse;)V",
        "success",
        "",
        "getSuccess",
        "()Z",
        "setSuccess",
        "(Z)V",
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
.field private data:Lcom/rokid/security/sdk/base/common/ota/SystemResponse;
    .annotation runtime Lcom/google/gson/annotations/SerializedName;
        value = "data"
    .end annotation
.end field

.field private success:Z
    .annotation runtime Lcom/google/gson/annotations/SerializedName;
        value = "success"
    .end annotation
.end field


# direct methods
.method public constructor <init>()V
    .locals 0

    .line 46
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public final getData()Lcom/rokid/security/sdk/base/common/ota/SystemResponse;
    .locals 1

    .line 52
    iget-object v0, p0, Lcom/rokid/security/sdk/base/common/ota/OTAResponse;->data:Lcom/rokid/security/sdk/base/common/ota/SystemResponse;

    return-object v0
.end method

.method public final getSuccess()Z
    .locals 1

    .line 49
    iget-boolean v0, p0, Lcom/rokid/security/sdk/base/common/ota/OTAResponse;->success:Z

    return v0
.end method

.method public final setData(Lcom/rokid/security/sdk/base/common/ota/SystemResponse;)V
    .locals 0
    .param p1, "<set-?>"    # Lcom/rokid/security/sdk/base/common/ota/SystemResponse;

    .line 52
    iput-object p1, p0, Lcom/rokid/security/sdk/base/common/ota/OTAResponse;->data:Lcom/rokid/security/sdk/base/common/ota/SystemResponse;

    return-void
.end method

.method public final setSuccess(Z)V
    .locals 0
    .param p1, "<set-?>"    # Z

    .line 49
    iput-boolean p1, p0, Lcom/rokid/security/sdk/base/common/ota/OTAResponse;->success:Z

    return-void
.end method
