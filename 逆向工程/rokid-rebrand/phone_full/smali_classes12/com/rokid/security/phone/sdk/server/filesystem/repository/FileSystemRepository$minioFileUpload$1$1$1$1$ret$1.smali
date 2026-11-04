.class final Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository$minioFileUpload$1$1$1$1$ret$1;
.super Lkotlin/jvm/internal/Lambda;
.source "FileSystemRepository.kt"

# interfaces
.implements Lkotlin/jvm/functions/Function0;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository$minioFileUpload$1$1$1$1;->invokeSuspend(Ljava/lang/Object;)Ljava/lang/Object;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x18
    name = null
.end annotation

.annotation system Ldalvik/annotation/Signature;
    value = {
        "Lkotlin/jvm/internal/Lambda;",
        "Lkotlin/jvm/functions/Function0<",
        "Lkotlinx/coroutines/flow/Flow<",
        "+",
        "Lcom/rokid/security/phone/sdk/base/utils/net/bean/BaseResponse2<",
        "Lcom/rokid/security/phone/sdk/server/filesystem/param/FileSavedInfo;",
        ">;>;>;"
    }
.end annotation

.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000\u0010\n\u0000\n\u0002\u0018\u0002\n\u0002\u0018\u0002\n\u0002\u0018\u0002\n\u0000\u0010\u0000\u001a\u000e\u0012\n\u0012\u0008\u0012\u0004\u0012\u00020\u00030\u00020\u0001H\n\u00a2\u0006\u0002\u0008\u0004"
    }
    d2 = {
        "<anonymous>",
        "Lkotlinx/coroutines/flow/Flow;",
        "Lcom/rokid/security/phone/sdk/base/utils/net/bean/BaseResponse2;",
        "Lcom/rokid/security/phone/sdk/server/filesystem/param/FileSavedInfo;",
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
.field final synthetic $captureTime:J

.field final synthetic $file:Ljava/io/File;

.field final synthetic $fileEndTime:Lkotlin/jvm/internal/Ref$LongRef;

.field final synthetic $fileSize:J

.field final synthetic $fileStartTime:Lkotlin/jvm/internal/Ref$LongRef;

.field final synthetic $finalMd5:Ljava/lang/String;

.field final synthetic $objectKey:Ljava/lang/String;

.field final synthetic $tag:Ljava/lang/String;

.field final synthetic $thumbnailsObjectKey:Ljava/lang/String;

.field final synthetic this$0:Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository;


# direct methods
.method constructor <init>(Ljava/io/File;Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository;Ljava/lang/String;JLjava/lang/String;Ljava/lang/String;Ljava/lang/String;JLkotlin/jvm/internal/Ref$LongRef;Lkotlin/jvm/internal/Ref$LongRef;)V
    .locals 1

    iput-object p1, p0, Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository$minioFileUpload$1$1$1$1$ret$1;->$file:Ljava/io/File;

    iput-object p2, p0, Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository$minioFileUpload$1$1$1$1$ret$1;->this$0:Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository;

    iput-object p3, p0, Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository$minioFileUpload$1$1$1$1$ret$1;->$tag:Ljava/lang/String;

    iput-wide p4, p0, Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository$minioFileUpload$1$1$1$1$ret$1;->$fileSize:J

    iput-object p6, p0, Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository$minioFileUpload$1$1$1$1$ret$1;->$objectKey:Ljava/lang/String;

    iput-object p7, p0, Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository$minioFileUpload$1$1$1$1$ret$1;->$finalMd5:Ljava/lang/String;

    iput-object p8, p0, Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository$minioFileUpload$1$1$1$1$ret$1;->$thumbnailsObjectKey:Ljava/lang/String;

    iput-wide p9, p0, Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository$minioFileUpload$1$1$1$1$ret$1;->$captureTime:J

    iput-object p11, p0, Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository$minioFileUpload$1$1$1$1$ret$1;->$fileStartTime:Lkotlin/jvm/internal/Ref$LongRef;

    iput-object p12, p0, Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository$minioFileUpload$1$1$1$1$ret$1;->$fileEndTime:Lkotlin/jvm/internal/Ref$LongRef;

    const/4 v0, 0x0

    invoke-direct {p0, v0}, Lkotlin/jvm/internal/Lambda;-><init>(I)V

    return-void
.end method


# virtual methods
.method public bridge synthetic invoke()Ljava/lang/Object;
    .locals 1

    .line 297
    invoke-virtual {p0}, Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository$minioFileUpload$1$1$1$1$ret$1;->invoke()Lkotlinx/coroutines/flow/Flow;

    move-result-object v0

    return-object v0
.end method

.method public final invoke()Lkotlinx/coroutines/flow/Flow;
    .locals 20
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Lkotlinx/coroutines/flow/Flow<",
            "Lcom/rokid/security/phone/sdk/base/utils/net/bean/BaseResponse2<",
            "Lcom/rokid/security/phone/sdk/server/filesystem/param/FileSavedInfo;",
            ">;>;"
        }
    .end annotation

    .line 298
    move-object/from16 v0, p0

    sget-object v1, Lcom/rokid/security/phone/sdk/server/filesystem/FileSystemManager;->INSTANCE:Lcom/rokid/security/phone/sdk/server/filesystem/FileSystemManager;

    iget-object v2, v0, Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository$minioFileUpload$1$1$1$1$ret$1;->$file:Ljava/io/File;

    invoke-virtual {v1, v2}, Lcom/rokid/security/phone/sdk/server/filesystem/FileSystemManager;->getMimeType(Ljava/io/File;)Ljava/lang/String;

    move-result-object v1

    .line 299
    .local v1, "mimeType":Ljava/lang/String;
    iget-object v3, v0, Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository$minioFileUpload$1$1$1$1$ret$1;->this$0:Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository;

    iget-object v5, v0, Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository$minioFileUpload$1$1$1$1$ret$1;->$tag:Ljava/lang/String;

    iget-wide v6, v0, Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository$minioFileUpload$1$1$1$1$ret$1;->$fileSize:J

    iget-object v8, v0, Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository$minioFileUpload$1$1$1$1$ret$1;->$objectKey:Ljava/lang/String;

    iget-object v9, v0, Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository$minioFileUpload$1$1$1$1$ret$1;->$finalMd5:Ljava/lang/String;

    iget-object v10, v0, Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository$minioFileUpload$1$1$1$1$ret$1;->$thumbnailsObjectKey:Ljava/lang/String;

    .line 300
    iget-wide v12, v0, Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository$minioFileUpload$1$1$1$1$ret$1;->$captureTime:J

    iget-object v2, v0, Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository$minioFileUpload$1$1$1$1$ret$1;->$fileStartTime:Lkotlin/jvm/internal/Ref$LongRef;

    iget-wide v14, v2, Lkotlin/jvm/internal/Ref$LongRef;->element:J

    iget-object v2, v0, Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository$minioFileUpload$1$1$1$1$ret$1;->$fileEndTime:Lkotlin/jvm/internal/Ref$LongRef;

    move-wide/from16 v16, v14

    iget-wide v14, v2, Lkotlin/jvm/internal/Ref$LongRef;->element:J

    .line 299
    const-string v4, ""

    move-object v11, v1

    move-wide/from16 v18, v14

    move-wide/from16 v14, v16

    move-wide/from16 v16, v18

    invoke-static/range {v3 .. v17}, Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository;->access$ossFileSave(Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository;Ljava/lang/String;Ljava/lang/String;JLjava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;JJJ)Lkotlinx/coroutines/flow/Flow;

    move-result-object v2

    return-object v2
.end method
