.class public final Lcom/rokid/security/phone/sdk/server/log/SdkLogManager$startUploadSDKLog$1;
.super Ljava/lang/Object;
.source "SdkLogManager.kt"

# interfaces
.implements Lcom/rokid/security/phone/sdk/base/data/callback/IResultCallback;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/rokid/security/phone/sdk/server/log/SdkLogManager;->startUploadSDKLog(Lcom/rokid/security/sdk/base/common/CollectLogResponseExtra;Ljava/lang/String;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x19
    name = null
.end annotation

.annotation system Ldalvik/annotation/Signature;
    value = {
        "Ljava/lang/Object;",
        "Lcom/rokid/security/phone/sdk/base/data/callback/IResultCallback<",
        "Lcom/rokid/security/phone/sdk/server/filesystem/param/FileSavedInfo;",
        ">;"
    }
.end annotation

.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000#\n\u0000\n\u0002\u0018\u0002\n\u0002\u0018\u0002\n\u0000\n\u0002\u0010\u0002\n\u0000\n\u0002\u0010\u0008\n\u0000\n\u0002\u0010\u000e\n\u0002\u0008\u0004*\u0001\u0000\u0008\n\u0018\u00002\u0008\u0012\u0004\u0012\u00020\u00020\u0001J!\u0010\u0003\u001a\u00020\u00042\u0008\u0010\u0005\u001a\u0004\u0018\u00010\u00062\u0008\u0010\u0007\u001a\u0004\u0018\u00010\u0008H\u0016\u00a2\u0006\u0002\u0010\tJ\u0012\u0010\n\u001a\u00020\u00042\u0008\u0010\u000b\u001a\u0004\u0018\u00010\u0002H\u0016\u00a8\u0006\u000c"
    }
    d2 = {
        "com/rokid/security/phone/sdk/server/log/SdkLogManager$startUploadSDKLog$1",
        "Lcom/rokid/security/phone/sdk/base/data/callback/IResultCallback;",
        "Lcom/rokid/security/phone/sdk/server/filesystem/param/FileSavedInfo;",
        "onFailed",
        "",
        "code",
        "",
        "errormsg",
        "",
        "(Ljava/lang/Integer;Ljava/lang/String;)V",
        "onSuccess",
        "data",
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


# instance fields
.field final synthetic $category:Ljava/lang/String;

.field final synthetic $extra:Lcom/rokid/security/sdk/base/common/CollectLogResponseExtra;

.field final synthetic $time:Ljava/lang/String;

.field final synthetic this$0:Lcom/rokid/security/phone/sdk/server/log/SdkLogManager;


# direct methods
.method constructor <init>(Lcom/rokid/security/phone/sdk/server/log/SdkLogManager;Ljava/lang/String;Lcom/rokid/security/sdk/base/common/CollectLogResponseExtra;Ljava/lang/String;)V
    .locals 0
    .param p1, "$receiver"    # Lcom/rokid/security/phone/sdk/server/log/SdkLogManager;
    .param p2, "$time"    # Ljava/lang/String;
    .param p3, "$extra"    # Lcom/rokid/security/sdk/base/common/CollectLogResponseExtra;
    .param p4, "$category"    # Ljava/lang/String;

    iput-object p1, p0, Lcom/rokid/security/phone/sdk/server/log/SdkLogManager$startUploadSDKLog$1;->this$0:Lcom/rokid/security/phone/sdk/server/log/SdkLogManager;

    iput-object p2, p0, Lcom/rokid/security/phone/sdk/server/log/SdkLogManager$startUploadSDKLog$1;->$time:Ljava/lang/String;

    iput-object p3, p0, Lcom/rokid/security/phone/sdk/server/log/SdkLogManager$startUploadSDKLog$1;->$extra:Lcom/rokid/security/sdk/base/common/CollectLogResponseExtra;

    iput-object p4, p0, Lcom/rokid/security/phone/sdk/server/log/SdkLogManager$startUploadSDKLog$1;->$category:Ljava/lang/String;

    .line 188
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onFailed(Ljava/lang/Integer;Ljava/lang/String;)V
    .locals 5
    .param p1, "code"    # Ljava/lang/Integer;
    .param p2, "errormsg"    # Ljava/lang/String;

    .line 195
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/log/SdkLogManager$startUploadSDKLog$1;->this$0:Lcom/rokid/security/phone/sdk/server/log/SdkLogManager;

    invoke-static {v0}, Lcom/rokid/security/phone/sdk/server/log/SdkLogManager;->access$getTAG$p(Lcom/rokid/security/phone/sdk/server/log/SdkLogManager;)Ljava/lang/String;

    move-result-object v0

    const-string/jumbo v1, "\u624b\u673a\u7aef\u65e5\u5fd7\u65e5\u5fd7\u6587\u4ef6\u4e0a\u4f20\u5931\u8d25"

    filled-new-array {v1}, [Ljava/lang/Object;

    move-result-object v1

    invoke-static {v0, v1}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->d(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 196
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/log/SdkLogManager$startUploadSDKLog$1;->this$0:Lcom/rokid/security/phone/sdk/server/log/SdkLogManager;

    iget-object v1, p0, Lcom/rokid/security/phone/sdk/server/log/SdkLogManager$startUploadSDKLog$1;->$time:Ljava/lang/String;

    iget-object v2, p0, Lcom/rokid/security/phone/sdk/server/log/SdkLogManager$startUploadSDKLog$1;->$extra:Lcom/rokid/security/sdk/base/common/CollectLogResponseExtra;

    iget-object v3, p0, Lcom/rokid/security/phone/sdk/server/log/SdkLogManager$startUploadSDKLog$1;->$category:Ljava/lang/String;

    const/4 v4, 0x0

    invoke-static {v0, v4, v1, v2, v3}, Lcom/rokid/security/phone/sdk/server/log/SdkLogManager;->access$startUploadGlassSdkLog(Lcom/rokid/security/phone/sdk/server/log/SdkLogManager;ZLjava/lang/String;Lcom/rokid/security/sdk/base/common/CollectLogResponseExtra;Ljava/lang/String;)V

    .line 197
    return-void
.end method

.method public onSuccess(Lcom/rokid/security/phone/sdk/server/filesystem/param/FileSavedInfo;)V
    .locals 5
    .param p1, "data"    # Lcom/rokid/security/phone/sdk/server/filesystem/param/FileSavedInfo;

    .line 190
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/log/SdkLogManager$startUploadSDKLog$1;->this$0:Lcom/rokid/security/phone/sdk/server/log/SdkLogManager;

    invoke-static {v0}, Lcom/rokid/security/phone/sdk/server/log/SdkLogManager;->access$getTAG$p(Lcom/rokid/security/phone/sdk/server/log/SdkLogManager;)Ljava/lang/String;

    move-result-object v0

    const-string/jumbo v1, "\u624b\u673a\u7aef\u65e5\u5fd7\u65e5\u5fd7\u6587\u4ef6\u4e0a\u4f20\u6210\u529f"

    filled-new-array {v1}, [Ljava/lang/Object;

    move-result-object v1

    invoke-static {v0, v1}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->d(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 191
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/log/SdkLogManager$startUploadSDKLog$1;->this$0:Lcom/rokid/security/phone/sdk/server/log/SdkLogManager;

    iget-object v1, p0, Lcom/rokid/security/phone/sdk/server/log/SdkLogManager$startUploadSDKLog$1;->$time:Ljava/lang/String;

    iget-object v2, p0, Lcom/rokid/security/phone/sdk/server/log/SdkLogManager$startUploadSDKLog$1;->$extra:Lcom/rokid/security/sdk/base/common/CollectLogResponseExtra;

    iget-object v3, p0, Lcom/rokid/security/phone/sdk/server/log/SdkLogManager$startUploadSDKLog$1;->$category:Ljava/lang/String;

    const/4 v4, 0x1

    invoke-static {v0, v4, v1, v2, v3}, Lcom/rokid/security/phone/sdk/server/log/SdkLogManager;->access$startUploadGlassSdkLog(Lcom/rokid/security/phone/sdk/server/log/SdkLogManager;ZLjava/lang/String;Lcom/rokid/security/sdk/base/common/CollectLogResponseExtra;Ljava/lang/String;)V

    .line 192
    return-void
.end method

.method public bridge synthetic onSuccess(Ljava/lang/Object;)V
    .locals 1
    .param p1, "data"    # Ljava/lang/Object;

    .line 188
    move-object v0, p1

    check-cast v0, Lcom/rokid/security/phone/sdk/server/filesystem/param/FileSavedInfo;

    invoke-virtual {p0, v0}, Lcom/rokid/security/phone/sdk/server/log/SdkLogManager$startUploadSDKLog$1;->onSuccess(Lcom/rokid/security/phone/sdk/server/filesystem/param/FileSavedInfo;)V

    return-void
.end method
