.class final Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository$uploadVideoThumbnailByOss$3$1$2;
.super Lkotlin/jvm/internal/Lambda;
.source "FileSystemRepository.kt"

# interfaces
.implements Lkotlin/jvm/functions/Function3;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository$uploadVideoThumbnailByOss$3;->invokeSuspend(Ljava/lang/Object;)Ljava/lang/Object;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x18
    name = null
.end annotation

.annotation system Ldalvik/annotation/Signature;
    value = {
        "Lkotlin/jvm/internal/Lambda;",
        "Lkotlin/jvm/functions/Function3<",
        "Ljava/lang/Long;",
        "Ljava/lang/String;",
        "Ljava/lang/String;",
        "Lkotlin/Unit;",
        ">;"
    }
.end annotation

.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000\u0016\n\u0000\n\u0002\u0010\u0002\n\u0000\n\u0002\u0010\t\n\u0000\n\u0002\u0010\u000e\n\u0002\u0008\u0002\u0010\u0000\u001a\u00020\u00012\u0006\u0010\u0002\u001a\u00020\u00032\u0006\u0010\u0004\u001a\u00020\u00052\u0006\u0010\u0006\u001a\u00020\u0005H\n\u00a2\u0006\u0002\u0008\u0007"
    }
    d2 = {
        "<anonymous>",
        "",
        "fileSize",
        "",
        "objectKey",
        "",
        "md5",
        "invoke"
    }
    k = 0x3
    mv = {
        0x1,
        0x8,
        0x0
    }
    xi = 0x30
.end annotation


# instance fields
.field final synthetic $bitmapFilePath:Ljava/lang/String;

.field final synthetic $thumbnailsObjectKey:Lkotlin/jvm/internal/Ref$ObjectRef;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Lkotlin/jvm/internal/Ref$ObjectRef<",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation
.end field

.field final synthetic this$0:Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository;


# direct methods
.method constructor <init>(Lkotlin/jvm/internal/Ref$ObjectRef;Ljava/lang/String;Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository;)V
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lkotlin/jvm/internal/Ref$ObjectRef<",
            "Ljava/lang/String;",
            ">;",
            "Ljava/lang/String;",
            "Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository;",
            ")V"
        }
    .end annotation

    iput-object p1, p0, Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository$uploadVideoThumbnailByOss$3$1$2;->$thumbnailsObjectKey:Lkotlin/jvm/internal/Ref$ObjectRef;

    iput-object p2, p0, Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository$uploadVideoThumbnailByOss$3$1$2;->$bitmapFilePath:Ljava/lang/String;

    iput-object p3, p0, Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository$uploadVideoThumbnailByOss$3$1$2;->this$0:Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository;

    const/4 v0, 0x3

    invoke-direct {p0, v0}, Lkotlin/jvm/internal/Lambda;-><init>(I)V

    return-void
.end method


# virtual methods
.method public bridge synthetic invoke(Ljava/lang/Object;Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;
    .locals 4
    .param p1, "p1"    # Ljava/lang/Object;
    .param p2, "p2"    # Ljava/lang/Object;
    .param p3, "p3"    # Ljava/lang/Object;

    .line 370
    move-object v0, p1

    check-cast v0, Ljava/lang/Number;

    invoke-virtual {v0}, Ljava/lang/Number;->longValue()J

    move-result-wide v0

    move-object v2, p2

    check-cast v2, Ljava/lang/String;

    move-object v3, p3

    check-cast v3, Ljava/lang/String;

    invoke-virtual {p0, v0, v1, v2, v3}, Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository$uploadVideoThumbnailByOss$3$1$2;->invoke(JLjava/lang/String;Ljava/lang/String;)V

    sget-object v0, Lkotlin/Unit;->INSTANCE:Lkotlin/Unit;

    return-object v0
.end method

.method public final invoke(JLjava/lang/String;Ljava/lang/String;)V
    .locals 3
    .param p1, "fileSize"    # J
    .param p3, "objectKey"    # Ljava/lang/String;
    .param p4, "md5"    # Ljava/lang/String;

    const-string v0, "objectKey"

    invoke-static {p3, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    const-string v0, "md5"

    invoke-static {p4, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 372
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository$uploadVideoThumbnailByOss$3$1$2;->$thumbnailsObjectKey:Lkotlin/jvm/internal/Ref$ObjectRef;

    iput-object p3, v0, Lkotlin/jvm/internal/Ref$ObjectRef;->element:Ljava/lang/Object;

    .line 374
    nop

    .line 375
    :try_start_0
    new-instance v0, Ljava/io/File;

    iget-object v1, p0, Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository$uploadVideoThumbnailByOss$3$1$2;->$bitmapFilePath:Ljava/lang/String;

    invoke-direct {v0, v1}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    invoke-virtual {v0}, Ljava/io/File;->delete()Z

    move-result v0

    if-eqz v0, :cond_0

    .line 376
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository$uploadVideoThumbnailByOss$3$1$2;->this$0:Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository;

    invoke-static {v0}, Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository;->access$getTAG$p(Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository;)Ljava/lang/String;

    move-result-object v0

    const-string/jumbo v1, "uploadVideoThumbnailByOss \u7f29\u7565\u56fe\u5220\u9664\u6210\u529f\u3002\u3002\u3002\u3002\u3002"

    filled-new-array {v1}, [Ljava/lang/Object;

    move-result-object v1

    invoke-static {v0, v1}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->d(Ljava/lang/String;[Ljava/lang/Object;)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    .line 378
    :catch_0
    move-exception v0

    .line 381
    :cond_0
    :goto_0
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository$uploadVideoThumbnailByOss$3$1$2;->this$0:Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository;

    invoke-static {v0}, Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository;->access$getTAG$p(Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository;)Ljava/lang/String;

    move-result-object v0

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string/jumbo v2, "thumbnailsObjectKey "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget-object v2, p0, Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository$uploadVideoThumbnailByOss$3$1$2;->$thumbnailsObjectKey:Lkotlin/jvm/internal/Ref$ObjectRef;

    iget-object v2, v2, Lkotlin/jvm/internal/Ref$ObjectRef;->element:Ljava/lang/Object;

    check-cast v2, Ljava/lang/String;

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    filled-new-array {v1}, [Ljava/lang/Object;

    move-result-object v1

    invoke-static {v0, v1}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->i(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 382
    return-void
.end method
