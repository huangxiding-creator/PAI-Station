.class final Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository$ossFileUpload$1$1$2;
.super Lkotlin/jvm/internal/Lambda;
.source "FileSystemRepository.kt"

# interfaces
.implements Lkotlin/jvm/functions/Function3;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository$ossFileUpload$1;->invokeSuspend(Ljava/lang/Object;)Ljava/lang/Object;
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
.field final synthetic $callback:Lcom/rokid/security/phone/sdk/base/data/callback/IResultCallback;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Lcom/rokid/security/phone/sdk/base/data/callback/IResultCallback<",
            "Lcom/rokid/security/phone/sdk/server/filesystem/param/FileSavedInfo;",
            ">;"
        }
    .end annotation
.end field

.field final synthetic $captureTime:J

.field final synthetic $file:Ljava/io/File;

.field final synthetic $fileEndTime:Lkotlin/jvm/internal/Ref$LongRef;

.field final synthetic $fileStartTime:Lkotlin/jvm/internal/Ref$LongRef;

.field final synthetic $preCalculatedMd5:Lkotlin/jvm/internal/Ref$ObjectRef;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Lkotlin/jvm/internal/Ref$ObjectRef<",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation
.end field

.field final synthetic $tag:Ljava/lang/String;

.field final synthetic $thumbnailsObjectKey:Ljava/lang/String;

.field final synthetic this$0:Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository;


# direct methods
.method constructor <init>(Lkotlin/jvm/internal/Ref$ObjectRef;Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository;Lcom/rokid/security/phone/sdk/base/data/callback/IResultCallback;Ljava/io/File;Ljava/lang/String;Ljava/lang/String;JLkotlin/jvm/internal/Ref$LongRef;Lkotlin/jvm/internal/Ref$LongRef;)V
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lkotlin/jvm/internal/Ref$ObjectRef<",
            "Ljava/lang/String;",
            ">;",
            "Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository;",
            "Lcom/rokid/security/phone/sdk/base/data/callback/IResultCallback<",
            "Lcom/rokid/security/phone/sdk/server/filesystem/param/FileSavedInfo;",
            ">;",
            "Ljava/io/File;",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            "J",
            "Lkotlin/jvm/internal/Ref$LongRef;",
            "Lkotlin/jvm/internal/Ref$LongRef;",
            ")V"
        }
    .end annotation

    iput-object p1, p0, Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository$ossFileUpload$1$1$2;->$preCalculatedMd5:Lkotlin/jvm/internal/Ref$ObjectRef;

    iput-object p2, p0, Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository$ossFileUpload$1$1$2;->this$0:Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository;

    iput-object p3, p0, Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository$ossFileUpload$1$1$2;->$callback:Lcom/rokid/security/phone/sdk/base/data/callback/IResultCallback;

    iput-object p4, p0, Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository$ossFileUpload$1$1$2;->$file:Ljava/io/File;

    iput-object p5, p0, Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository$ossFileUpload$1$1$2;->$tag:Ljava/lang/String;

    iput-object p6, p0, Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository$ossFileUpload$1$1$2;->$thumbnailsObjectKey:Ljava/lang/String;

    iput-wide p7, p0, Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository$ossFileUpload$1$1$2;->$captureTime:J

    iput-object p9, p0, Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository$ossFileUpload$1$1$2;->$fileStartTime:Lkotlin/jvm/internal/Ref$LongRef;

    iput-object p10, p0, Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository$ossFileUpload$1$1$2;->$fileEndTime:Lkotlin/jvm/internal/Ref$LongRef;

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

    .line 208
    move-object v0, p1

    check-cast v0, Ljava/lang/Number;

    invoke-virtual {v0}, Ljava/lang/Number;->longValue()J

    move-result-wide v0

    move-object v2, p2

    check-cast v2, Ljava/lang/String;

    move-object v3, p3

    check-cast v3, Ljava/lang/String;

    invoke-virtual {p0, v0, v1, v2, v3}, Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository$ossFileUpload$1$1$2;->invoke(JLjava/lang/String;Ljava/lang/String;)V

    sget-object v0, Lkotlin/Unit;->INSTANCE:Lkotlin/Unit;

    return-object v0
.end method

.method public final invoke(JLjava/lang/String;Ljava/lang/String;)V
    .locals 22
    .param p1, "fileSize"    # J
    .param p3, "objectKey"    # Ljava/lang/String;
    .param p4, "md5"    # Ljava/lang/String;

    move-object/from16 v0, p0

    const-string v1, "objectKey"

    move-object/from16 v15, p3

    invoke-static {v15, v1}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    const-string v1, "md5"

    move-object/from16 v13, p4

    invoke-static {v13, v1}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 211
    invoke-static {}, Lcom/rokid/security/phone/sdk/base/utils/other/ScopesKt;->getDefaultScope()Lkotlinx/coroutines/CoroutineScope;

    move-result-object v1

    new-instance v18, Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository$ossFileUpload$1$1$2$1;

    iget-object v3, v0, Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository$ossFileUpload$1$1$2;->$preCalculatedMd5:Lkotlin/jvm/internal/Ref$ObjectRef;

    iget-object v5, v0, Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository$ossFileUpload$1$1$2;->this$0:Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository;

    iget-object v6, v0, Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository$ossFileUpload$1$1$2;->$callback:Lcom/rokid/security/phone/sdk/base/data/callback/IResultCallback;

    iget-object v7, v0, Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository$ossFileUpload$1$1$2;->$file:Ljava/io/File;

    iget-object v8, v0, Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository$ossFileUpload$1$1$2;->$tag:Ljava/lang/String;

    iget-object v12, v0, Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository$ossFileUpload$1$1$2;->$thumbnailsObjectKey:Ljava/lang/String;

    iget-wide v9, v0, Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository$ossFileUpload$1$1$2;->$captureTime:J

    iget-object v14, v0, Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository$ossFileUpload$1$1$2;->$fileStartTime:Lkotlin/jvm/internal/Ref$LongRef;

    iget-object v11, v0, Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository$ossFileUpload$1$1$2;->$fileEndTime:Lkotlin/jvm/internal/Ref$LongRef;

    const/16 v17, 0x0

    move-object/from16 v2, v18

    move-object/from16 v4, p4

    move-wide/from16 v19, v9

    move-wide/from16 v9, p1

    move-object/from16 v16, v11

    move-object/from16 v11, p3

    move-object/from16 v21, v14

    move-wide/from16 v13, v19

    move-object/from16 v15, v21

    invoke-direct/range {v2 .. v17}, Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository$ossFileUpload$1$1$2$1;-><init>(Lkotlin/jvm/internal/Ref$ObjectRef;Ljava/lang/String;Lcom/rokid/security/phone/sdk/server/filesystem/repository/FileSystemRepository;Lcom/rokid/security/phone/sdk/base/data/callback/IResultCallback;Ljava/io/File;Ljava/lang/String;JLjava/lang/String;Ljava/lang/String;JLkotlin/jvm/internal/Ref$LongRef;Lkotlin/jvm/internal/Ref$LongRef;Lkotlin/coroutines/Continuation;)V

    move-object/from16 v5, v18

    check-cast v5, Lkotlin/jvm/functions/Function2;

    const/4 v6, 0x3

    const/4 v7, 0x0

    const/4 v3, 0x0

    const/4 v4, 0x0

    move-object v2, v1

    invoke-static/range {v2 .. v7}, Lkotlinx/coroutines/BuildersKt;->launch$default(Lkotlinx/coroutines/CoroutineScope;Lkotlin/coroutines/CoroutineContext;Lkotlinx/coroutines/CoroutineStart;Lkotlin/jvm/functions/Function2;ILjava/lang/Object;)Lkotlinx/coroutines/Job;

    .line 230
    return-void
.end method
