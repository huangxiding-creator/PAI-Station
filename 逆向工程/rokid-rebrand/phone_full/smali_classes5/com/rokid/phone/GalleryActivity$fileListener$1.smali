.class public final Lcom/rokid/phone/GalleryActivity$fileListener$1;
.super Ljava/lang/Object;
.source "GalleryActivity.kt"

# interfaces
.implements Lcom/rokid/security/phone/sdk/api/msg/listener/FileReceiveV2Listener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/rokid/phone/GalleryActivity;-><init>()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x19
    name = null
.end annotation

.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000!\n\u0000\n\u0002\u0018\u0002\n\u0000\n\u0002\u0010\u0002\n\u0000\n\u0002\u0010\u000e\n\u0002\u0008\u0002\n\u0002\u0010\u0007\n\u0002\u0008\u0004*\u0001\u0000\u0008\n\u0018\u00002\u00020\u0001J\u0010\u0010\u0002\u001a\u00020\u00032\u0006\u0010\u0004\u001a\u00020\u0005H\u0016J\u0018\u0010\u0006\u001a\u00020\u00032\u0006\u0010\u0004\u001a\u00020\u00052\u0006\u0010\u0007\u001a\u00020\u0008H\u0016J\u0010\u0010\t\u001a\u00020\u00032\u0006\u0010\u0004\u001a\u00020\u0005H\u0016J\u0008\u0010\n\u001a\u00020\u0003H\u0016J\u0010\u0010\u000b\u001a\u00020\u00032\u0006\u0010\u0004\u001a\u00020\u0005H\u0016\u00a8\u0006\u000c"
    }
    d2 = {
        "com/rokid/phone/GalleryActivity$fileListener$1",
        "Lcom/rokid/security/phone/sdk/api/msg/listener/FileReceiveV2Listener;",
        "onStart",
        "",
        "filePath",
        "",
        "onProgressChanged",
        "progress",
        "",
        "onComplete",
        "onFail",
        "onCancel",
        "app_debug"
    }
    k = 0x1
    mv = {
        0x2,
        0x2,
        0x0
    }
    xi = 0x30
.end annotation


# instance fields
.field final synthetic this$0:Lcom/rokid/phone/GalleryActivity;


# direct methods
.method constructor <init>(Lcom/rokid/phone/GalleryActivity;)V
    .locals 0
    .param p1, "$receiver"    # Lcom/rokid/phone/GalleryActivity;

    iput-object p1, p0, Lcom/rokid/phone/GalleryActivity$fileListener$1;->this$0:Lcom/rokid/phone/GalleryActivity;

    .line 23
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onCancel(Ljava/lang/String;)V
    .locals 2
    .param p1, "filePath"    # Ljava/lang/String;

    const-string v0, "filePath"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 42
    iget-object v0, p0, Lcom/rokid/phone/GalleryActivity$fileListener$1;->this$0:Lcom/rokid/phone/GalleryActivity;

    invoke-static {v0}, Lcom/rokid/phone/GalleryActivity;->access$getBinding(Lcom/rokid/phone/GalleryActivity;)Lcom/rokid/phone/databinding/ActivityGalleryBinding;

    move-result-object v0

    iget-object v0, v0, Lcom/rokid/phone/databinding/ActivityGalleryBinding;->receiveProgress:Landroid/widget/TextView;

    const/16 v1, 0x8

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setVisibility(I)V

    .line 43
    return-void
.end method

.method public onComplete(Ljava/lang/String;)V
    .locals 2
    .param p1, "filePath"    # Ljava/lang/String;

    const-string v0, "filePath"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 33
    iget-object v0, p0, Lcom/rokid/phone/GalleryActivity$fileListener$1;->this$0:Lcom/rokid/phone/GalleryActivity;

    invoke-static {v0}, Lcom/rokid/phone/GalleryActivity;->access$getBinding(Lcom/rokid/phone/GalleryActivity;)Lcom/rokid/phone/databinding/ActivityGalleryBinding;

    move-result-object v0

    iget-object v0, v0, Lcom/rokid/phone/databinding/ActivityGalleryBinding;->receiveProgress:Landroid/widget/TextView;

    const/16 v1, 0x8

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setVisibility(I)V

    .line 34
    iget-object v0, p0, Lcom/rokid/phone/GalleryActivity$fileListener$1;->this$0:Lcom/rokid/phone/GalleryActivity;

    invoke-static {v0}, Lcom/rokid/phone/GalleryActivity;->access$loadMedia(Lcom/rokid/phone/GalleryActivity;)V

    .line 35
    return-void
.end method

.method public onFail()V
    .locals 2

    .line 38
    iget-object v0, p0, Lcom/rokid/phone/GalleryActivity$fileListener$1;->this$0:Lcom/rokid/phone/GalleryActivity;

    invoke-static {v0}, Lcom/rokid/phone/GalleryActivity;->access$getBinding(Lcom/rokid/phone/GalleryActivity;)Lcom/rokid/phone/databinding/ActivityGalleryBinding;

    move-result-object v0

    iget-object v0, v0, Lcom/rokid/phone/databinding/ActivityGalleryBinding;->receiveProgress:Landroid/widget/TextView;

    const/16 v1, 0x8

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setVisibility(I)V

    .line 39
    return-void
.end method

.method public onProgressChanged(Ljava/lang/String;F)V
    .locals 3
    .param p1, "filePath"    # Ljava/lang/String;
    .param p2, "progress"    # F

    const-string v0, "filePath"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 29
    iget-object v0, p0, Lcom/rokid/phone/GalleryActivity$fileListener$1;->this$0:Lcom/rokid/phone/GalleryActivity;

    sget v1, Lcom/rokid/phone/R$string;->demo_receiving_progress:I

    float-to-int v2, p2

    invoke-static {v2}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    filled-new-array {v2}, [Ljava/lang/Object;

    move-result-object v2

    invoke-static {v1, v2}, Lcom/rokid/phone/utils/DemoStringsKt;->demoString(I[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Lcom/rokid/phone/GalleryActivity;->access$showProgress(Lcom/rokid/phone/GalleryActivity;Ljava/lang/String;)V

    .line 30
    return-void
.end method

.method public onStart(Ljava/lang/String;)V
    .locals 3
    .param p1, "filePath"    # Ljava/lang/String;

    const-string v0, "filePath"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 25
    iget-object v0, p0, Lcom/rokid/phone/GalleryActivity$fileListener$1;->this$0:Lcom/rokid/phone/GalleryActivity;

    sget v1, Lcom/rokid/phone/R$string;->demo_receiving_file:I

    const/4 v2, 0x0

    new-array v2, v2, [Ljava/lang/Object;

    invoke-static {v1, v2}, Lcom/rokid/phone/utils/DemoStringsKt;->demoString(I[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Lcom/rokid/phone/GalleryActivity;->access$showProgress(Lcom/rokid/phone/GalleryActivity;Ljava/lang/String;)V

    .line 26
    return-void
.end method
