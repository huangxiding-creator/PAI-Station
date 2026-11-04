.class final Lcom/rokid/security/phone/sdk/server/msg/file/ApkSender$sendFile$3;
.super Lkotlin/coroutines/jvm/internal/SuspendLambda;
.source "ApkSender.kt"

# interfaces
.implements Lkotlin/jvm/functions/Function2;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/rokid/security/phone/sdk/server/msg/file/ApkSender;->sendFile(Ljava/net/Socket;Ljava/io/File;Lcom/rokid/security/sdk/base/common/apk/TransferProgressListener;Lkotlin/coroutines/Continuation;)Ljava/lang/Object;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x18
    name = null
.end annotation

.annotation system Ldalvik/annotation/Signature;
    value = {
        "Lkotlin/coroutines/jvm/internal/SuspendLambda;",
        "Lkotlin/jvm/functions/Function2<",
        "Lkotlinx/coroutines/CoroutineScope;",
        "Lkotlin/coroutines/Continuation<",
        "-",
        "Lkotlin/Unit;",
        ">;",
        "Ljava/lang/Object;",
        ">;"
    }
.end annotation

.annotation system Ldalvik/annotation/SourceDebugExtension;
    value = "SMAP\nApkSender.kt\nKotlin\n*S Kotlin\n*F\n+ 1 ApkSender.kt\ncom/rokid/security/phone/sdk/server/msg/file/ApkSender$sendFile$3\n+ 2 fake.kt\nkotlin/jvm/internal/FakeKt\n*L\n1#1,214:1\n1#2:215\n*E\n"
.end annotation

.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000\n\n\u0000\n\u0002\u0010\u0002\n\u0002\u0018\u0002\u0010\u0000\u001a\u0004\u0018\u00010\u0001*\u00020\u0002H\u008a@"
    }
    d2 = {
        "<anonymous>",
        "",
        "Lkotlinx/coroutines/CoroutineScope;"
    }
    k = 0x3
    mv = {
        0x1,
        0x8,
        0x0
    }
    xi = 0x30
.end annotation

.annotation runtime Lkotlin/coroutines/jvm/internal/DebugMetadata;
    c = "com.rokid.security.phone.sdk.server.msg.file.ApkSender$sendFile$3"
    f = "ApkSender.kt"
    i = {
        0x0,
        0x0,
        0x0,
        0x0,
        0x0,
        0x0,
        0x0,
        0x1,
        0x1,
        0x2,
        0x2,
        0x3,
        0x3
    }
    l = {
        0x72,
        0x7f,
        0x83,
        0x8d
    }
    m = "invokeSuspend"
    n = {
        "dataOut",
        "fileIn",
        "buffer",
        "bytesRead",
        "totalTransferred",
        "fileLength",
        "currentTime",
        "dataOut",
        "fileIn",
        "dataOut",
        "fileIn",
        "dataOut",
        "fileIn"
    }
    s = {
        "L$0",
        "L$1",
        "L$2",
        "L$3",
        "L$4",
        "J$0",
        "J$1",
        "L$0",
        "L$1",
        "L$0",
        "L$1",
        "L$0",
        "L$1"
    }
.end annotation


# instance fields
.field final synthetic $file:Ljava/io/File;

.field final synthetic $listener:Lcom/rokid/security/sdk/base/common/apk/TransferProgressListener;

.field final synthetic $socket:Ljava/net/Socket;

.field J$0:J

.field J$1:J

.field L$0:Ljava/lang/Object;

.field L$1:Ljava/lang/Object;

.field L$2:Ljava/lang/Object;

.field L$3:Ljava/lang/Object;

.field L$4:Ljava/lang/Object;

.field label:I

.field final synthetic this$0:Lcom/rokid/security/phone/sdk/server/msg/file/ApkSender;


# direct methods
.method constructor <init>(Lcom/rokid/security/phone/sdk/server/msg/file/ApkSender;Ljava/io/File;Ljava/net/Socket;Lcom/rokid/security/sdk/base/common/apk/TransferProgressListener;Lkotlin/coroutines/Continuation;)V
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lcom/rokid/security/phone/sdk/server/msg/file/ApkSender;",
            "Ljava/io/File;",
            "Ljava/net/Socket;",
            "Lcom/rokid/security/sdk/base/common/apk/TransferProgressListener;",
            "Lkotlin/coroutines/Continuation<",
            "-",
            "Lcom/rokid/security/phone/sdk/server/msg/file/ApkSender$sendFile$3;",
            ">;)V"
        }
    .end annotation

    iput-object p1, p0, Lcom/rokid/security/phone/sdk/server/msg/file/ApkSender$sendFile$3;->this$0:Lcom/rokid/security/phone/sdk/server/msg/file/ApkSender;

    iput-object p2, p0, Lcom/rokid/security/phone/sdk/server/msg/file/ApkSender$sendFile$3;->$file:Ljava/io/File;

    iput-object p3, p0, Lcom/rokid/security/phone/sdk/server/msg/file/ApkSender$sendFile$3;->$socket:Ljava/net/Socket;

    iput-object p4, p0, Lcom/rokid/security/phone/sdk/server/msg/file/ApkSender$sendFile$3;->$listener:Lcom/rokid/security/sdk/base/common/apk/TransferProgressListener;

    const/4 v0, 0x2

    invoke-direct {p0, v0, p5}, Lkotlin/coroutines/jvm/internal/SuspendLambda;-><init>(ILkotlin/coroutines/Continuation;)V

    return-void
.end method


# virtual methods
.method public final create(Ljava/lang/Object;Lkotlin/coroutines/Continuation;)Lkotlin/coroutines/Continuation;
    .locals 7
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/Object;",
            "Lkotlin/coroutines/Continuation<",
            "*>;)",
            "Lkotlin/coroutines/Continuation<",
            "Lkotlin/Unit;",
            ">;"
        }
    .end annotation

    new-instance v6, Lcom/rokid/security/phone/sdk/server/msg/file/ApkSender$sendFile$3;

    iget-object v1, p0, Lcom/rokid/security/phone/sdk/server/msg/file/ApkSender$sendFile$3;->this$0:Lcom/rokid/security/phone/sdk/server/msg/file/ApkSender;

    iget-object v2, p0, Lcom/rokid/security/phone/sdk/server/msg/file/ApkSender$sendFile$3;->$file:Ljava/io/File;

    iget-object v3, p0, Lcom/rokid/security/phone/sdk/server/msg/file/ApkSender$sendFile$3;->$socket:Ljava/net/Socket;

    iget-object v4, p0, Lcom/rokid/security/phone/sdk/server/msg/file/ApkSender$sendFile$3;->$listener:Lcom/rokid/security/sdk/base/common/apk/TransferProgressListener;

    move-object v0, v6

    move-object v5, p2

    invoke-direct/range {v0 .. v5}, Lcom/rokid/security/phone/sdk/server/msg/file/ApkSender$sendFile$3;-><init>(Lcom/rokid/security/phone/sdk/server/msg/file/ApkSender;Ljava/io/File;Ljava/net/Socket;Lcom/rokid/security/sdk/base/common/apk/TransferProgressListener;Lkotlin/coroutines/Continuation;)V

    check-cast v6, Lkotlin/coroutines/Continuation;

    return-object v6
.end method

.method public bridge synthetic invoke(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;
    .locals 1

    check-cast p1, Lkotlinx/coroutines/CoroutineScope;

    check-cast p2, Lkotlin/coroutines/Continuation;

    invoke-virtual {p0, p1, p2}, Lcom/rokid/security/phone/sdk/server/msg/file/ApkSender$sendFile$3;->invoke(Lkotlinx/coroutines/CoroutineScope;Lkotlin/coroutines/Continuation;)Ljava/lang/Object;

    move-result-object v0

    return-object v0
.end method

.method public final invoke(Lkotlinx/coroutines/CoroutineScope;Lkotlin/coroutines/Continuation;)Ljava/lang/Object;
    .locals 2
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lkotlinx/coroutines/CoroutineScope;",
            "Lkotlin/coroutines/Continuation<",
            "-",
            "Lkotlin/Unit;",
            ">;)",
            "Ljava/lang/Object;"
        }
    .end annotation

    invoke-virtual {p0, p1, p2}, Lcom/rokid/security/phone/sdk/server/msg/file/ApkSender$sendFile$3;->create(Ljava/lang/Object;Lkotlin/coroutines/Continuation;)Lkotlin/coroutines/Continuation;

    move-result-object v0

    check-cast v0, Lcom/rokid/security/phone/sdk/server/msg/file/ApkSender$sendFile$3;

    sget-object v1, Lkotlin/Unit;->INSTANCE:Lkotlin/Unit;

    invoke-virtual {v0, v1}, Lcom/rokid/security/phone/sdk/server/msg/file/ApkSender$sendFile$3;->invokeSuspend(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    return-object v0
.end method

.method public final invokeSuspend(Ljava/lang/Object;)Ljava/lang/Object;
    .locals 26

    const-string v0, "file.name"

    invoke-static {}, Lkotlin/coroutines/intrinsics/IntrinsicsKt;->getCOROUTINE_SUSPENDED()Ljava/lang/Object;

    move-result-object v1

    .line 81
    move-object/from16 v2, p0

    iget v3, v2, Lcom/rokid/security/phone/sdk/server/msg/file/ApkSender$sendFile$3;->label:I

    const/4 v4, 0x1

    const-string/jumbo v7, "\u5173\u95ed\u6d41\u51fa\u9519"

    packed-switch v3, :pswitch_data_0

    new-instance v0, Ljava/lang/IllegalStateException;

    const-string v1, "call to \'resume\' before \'invoke\' with coroutine"

    invoke-direct {v0, v1}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/String;)V

    throw v0

    :pswitch_0
    move-object/from16 v1, p0

    .local v1, "this":Lcom/rokid/security/phone/sdk/server/msg/file/ApkSender$sendFile$3;
    move-object/from16 v3, p1

    .local v3, "$result":Ljava/lang/Object;
    iget-object v0, v1, Lcom/rokid/security/phone/sdk/server/msg/file/ApkSender$sendFile$3;->L$1:Ljava/lang/Object;

    move-object v4, v0

    check-cast v4, Ljava/io/FileInputStream;

    .local v4, "fileIn":Ljava/io/FileInputStream;
    iget-object v0, v1, Lcom/rokid/security/phone/sdk/server/msg/file/ApkSender$sendFile$3;->L$0:Ljava/lang/Object;

    move-object v5, v0

    check-cast v5, Ljava/io/DataOutputStream;

    .local v5, "dataOut":Ljava/io/DataOutputStream;
    :try_start_0
    invoke-static {v3}, Lkotlin/ResultKt;->throwOnFailure(Ljava/lang/Object;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    move-object v6, v5

    move-object v5, v3

    goto/16 :goto_c

    .line 145
    :catchall_0
    move-exception v0

    move-object v2, v0

    goto/16 :goto_11

    .line 81
    .end local v1    # "this":Lcom/rokid/security/phone/sdk/server/msg/file/ApkSender$sendFile$3;
    .end local v3    # "$result":Ljava/lang/Object;
    .end local v4    # "fileIn":Ljava/io/FileInputStream;
    .end local v5    # "dataOut":Ljava/io/DataOutputStream;
    :pswitch_1
    move-object/from16 v3, p0

    .local v3, "this":Lcom/rokid/security/phone/sdk/server/msg/file/ApkSender$sendFile$3;
    move-object/from16 v4, p1

    .local v4, "$result":Ljava/lang/Object;
    iget-object v0, v3, Lcom/rokid/security/phone/sdk/server/msg/file/ApkSender$sendFile$3;->L$1:Ljava/lang/Object;

    move-object v9, v0

    check-cast v9, Ljava/io/FileInputStream;

    .local v9, "fileIn":Ljava/io/FileInputStream;
    iget-object v0, v3, Lcom/rokid/security/phone/sdk/server/msg/file/ApkSender$sendFile$3;->L$0:Ljava/lang/Object;

    move-object v10, v0

    check-cast v10, Ljava/io/DataOutputStream;

    .local v10, "dataOut":Ljava/io/DataOutputStream;
    :try_start_1
    invoke-static {v4}, Lkotlin/ResultKt;->throwOnFailure(Ljava/lang/Object;)V
    :try_end_1
    .catch Ljava/io/IOException; {:try_start_1 .. :try_end_1} :catch_0
    .catchall {:try_start_1 .. :try_end_1} :catchall_1

    move-object/from16 v22, v7

    goto/16 :goto_4

    .end local v3    # "this":Lcom/rokid/security/phone/sdk/server/msg/file/ApkSender$sendFile$3;
    .end local v4    # "$result":Ljava/lang/Object;
    .end local v9    # "fileIn":Ljava/io/FileInputStream;
    .end local v10    # "dataOut":Ljava/io/DataOutputStream;
    :pswitch_2
    move-object/from16 v3, p0

    .restart local v3    # "this":Lcom/rokid/security/phone/sdk/server/msg/file/ApkSender$sendFile$3;
    move-object/from16 v4, p1

    .restart local v4    # "$result":Ljava/lang/Object;
    iget-object v0, v3, Lcom/rokid/security/phone/sdk/server/msg/file/ApkSender$sendFile$3;->L$1:Ljava/lang/Object;

    move-object v9, v0

    check-cast v9, Ljava/io/FileInputStream;

    .restart local v9    # "fileIn":Ljava/io/FileInputStream;
    iget-object v0, v3, Lcom/rokid/security/phone/sdk/server/msg/file/ApkSender$sendFile$3;->L$0:Ljava/lang/Object;

    move-object v10, v0

    check-cast v10, Ljava/io/DataOutputStream;

    .restart local v10    # "dataOut":Ljava/io/DataOutputStream;
    :try_start_2
    invoke-static {v4}, Lkotlin/ResultKt;->throwOnFailure(Ljava/lang/Object;)V
    :try_end_2
    .catch Ljava/io/IOException; {:try_start_2 .. :try_end_2} :catch_0
    .catchall {:try_start_2 .. :try_end_2} :catchall_1

    move-object/from16 v22, v7

    goto/16 :goto_3

    .line 145
    :catchall_1
    move-exception v0

    move-object v2, v0

    move-object v1, v3

    move-object v3, v4

    move-object v4, v9

    move-object v5, v10

    goto/16 :goto_11

    .line 139
    :catch_0
    move-exception v0

    move-object v5, v4

    move-object v4, v9

    move-object v6, v10

    move-object/from16 v23, v3

    move-object v3, v1

    move-object/from16 v1, v23

    goto/16 :goto_b

    .line 81
    .end local v3    # "this":Lcom/rokid/security/phone/sdk/server/msg/file/ApkSender$sendFile$3;
    .end local v4    # "$result":Ljava/lang/Object;
    .end local v9    # "fileIn":Ljava/io/FileInputStream;
    .end local v10    # "dataOut":Ljava/io/DataOutputStream;
    :pswitch_3
    move-object/from16 v3, p0

    .restart local v3    # "this":Lcom/rokid/security/phone/sdk/server/msg/file/ApkSender$sendFile$3;
    move-object/from16 v9, p1

    .local v9, "$result":Ljava/lang/Object;
    iget-wide v10, v3, Lcom/rokid/security/phone/sdk/server/msg/file/ApkSender$sendFile$3;->J$1:J

    .local v10, "currentTime":J
    iget-wide v12, v3, Lcom/rokid/security/phone/sdk/server/msg/file/ApkSender$sendFile$3;->J$0:J

    .local v12, "fileLength":J
    iget-object v0, v3, Lcom/rokid/security/phone/sdk/server/msg/file/ApkSender$sendFile$3;->L$4:Ljava/lang/Object;

    check-cast v0, Lkotlin/jvm/internal/Ref$LongRef;

    .local v0, "totalTransferred":Lkotlin/jvm/internal/Ref$LongRef;
    iget-object v14, v3, Lcom/rokid/security/phone/sdk/server/msg/file/ApkSender$sendFile$3;->L$3:Ljava/lang/Object;

    check-cast v14, Lkotlin/jvm/internal/Ref$IntRef;

    .local v14, "bytesRead":Lkotlin/jvm/internal/Ref$IntRef;
    iget-object v15, v3, Lcom/rokid/security/phone/sdk/server/msg/file/ApkSender$sendFile$3;->L$2:Ljava/lang/Object;

    check-cast v15, [B

    .local v15, "buffer":[B
    iget-object v6, v3, Lcom/rokid/security/phone/sdk/server/msg/file/ApkSender$sendFile$3;->L$1:Ljava/lang/Object;

    check-cast v6, Ljava/io/FileInputStream;

    .local v6, "fileIn":Ljava/io/FileInputStream;
    iget-object v5, v3, Lcom/rokid/security/phone/sdk/server/msg/file/ApkSender$sendFile$3;->L$0:Ljava/lang/Object;

    check-cast v5, Ljava/io/DataOutputStream;

    .restart local v5    # "dataOut":Ljava/io/DataOutputStream;
    :try_start_3
    invoke-static {v9}, Lkotlin/ResultKt;->throwOnFailure(Ljava/lang/Object;)V
    :try_end_3
    .catch Ljava/io/IOException; {:try_start_3 .. :try_end_3} :catch_1
    .catchall {:try_start_3 .. :try_end_3} :catchall_2

    move-object/from16 v22, v7

    move-wide v7, v10

    move v10, v4

    move-object/from16 v23, v3

    move-object v3, v1

    move-object/from16 v1, v23

    move-object/from16 v24, v6

    move-object v6, v5

    move-object v5, v9

    move-object/from16 v9, v24

    goto/16 :goto_2

    .line 145
    .end local v0    # "totalTransferred":Lkotlin/jvm/internal/Ref$LongRef;
    .end local v10    # "currentTime":J
    .end local v12    # "fileLength":J
    .end local v14    # "bytesRead":Lkotlin/jvm/internal/Ref$IntRef;
    .end local v15    # "buffer":[B
    :catchall_2
    move-exception v0

    move-object v2, v0

    move-object v1, v3

    move-object v4, v6

    move-object v3, v9

    goto/16 :goto_11

    .line 139
    :catch_1
    move-exception v0

    move-object v4, v6

    move-object v6, v5

    move-object v5, v9

    move-object/from16 v23, v3

    move-object v3, v1

    move-object/from16 v1, v23

    goto/16 :goto_b

    .line 81
    .end local v3    # "this":Lcom/rokid/security/phone/sdk/server/msg/file/ApkSender$sendFile$3;
    .end local v5    # "dataOut":Ljava/io/DataOutputStream;
    .end local v6    # "fileIn":Ljava/io/FileInputStream;
    .end local v9    # "$result":Ljava/lang/Object;
    :pswitch_4
    invoke-static/range {p1 .. p1}, Lkotlin/ResultKt;->throwOnFailure(Ljava/lang/Object;)V

    move-object/from16 v3, p0

    .restart local v3    # "this":Lcom/rokid/security/phone/sdk/server/msg/file/ApkSender$sendFile$3;
    move-object/from16 v5, p1

    .line 82
    .local v5, "$result":Ljava/lang/Object;
    const/4 v6, 0x0

    .line 83
    .local v6, "dataOut":Ljava/io/DataOutputStream;
    const/4 v9, 0x0

    .line 85
    .local v9, "fileIn":Ljava/io/FileInputStream;
    nop

    .line 86
    :try_start_4
    iget-object v10, v3, Lcom/rokid/security/phone/sdk/server/msg/file/ApkSender$sendFile$3;->this$0:Lcom/rokid/security/phone/sdk/server/msg/file/ApkSender;

    invoke-static {v10}, Lcom/rokid/security/phone/sdk/server/msg/file/ApkSender;->access$getTAG$p(Lcom/rokid/security/phone/sdk/server/msg/file/ApkSender;)Ljava/lang/String;

    move-result-object v10

    new-instance v11, Ljava/lang/StringBuilder;

    invoke-direct {v11}, Ljava/lang/StringBuilder;-><init>()V

    const-string/jumbo v12, "sendFile file exist? "

    invoke-virtual {v11, v12}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v11

    iget-object v12, v3, Lcom/rokid/security/phone/sdk/server/msg/file/ApkSender$sendFile$3;->$file:Ljava/io/File;

    invoke-virtual {v12}, Ljava/io/File;->exists()Z

    move-result v12

    invoke-virtual {v11, v12}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v11

    invoke-virtual {v11}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v11

    filled-new-array {v11}, [Ljava/lang/Object;

    move-result-object v11

    invoke-static {v10, v11}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->i(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 87
    new-instance v10, Ljava/io/DataOutputStream;

    iget-object v11, v3, Lcom/rokid/security/phone/sdk/server/msg/file/ApkSender$sendFile$3;->$socket:Ljava/net/Socket;

    invoke-virtual {v11}, Ljava/net/Socket;->getOutputStream()Ljava/io/OutputStream;

    move-result-object v11

    invoke-direct {v10, v11}, Ljava/io/DataOutputStream;-><init>(Ljava/io/OutputStream;)V

    move-object v6, v10

    .line 88
    new-instance v10, Ljava/io/FileInputStream;

    iget-object v11, v3, Lcom/rokid/security/phone/sdk/server/msg/file/ApkSender$sendFile$3;->$file:Ljava/io/File;

    invoke-direct {v10, v11}, Ljava/io/FileInputStream;-><init>(Ljava/io/File;)V

    move-object v9, v10

    .line 91
    iget-object v10, v3, Lcom/rokid/security/phone/sdk/server/msg/file/ApkSender$sendFile$3;->this$0:Lcom/rokid/security/phone/sdk/server/msg/file/ApkSender;

    iget-object v11, v3, Lcom/rokid/security/phone/sdk/server/msg/file/ApkSender$sendFile$3;->$file:Ljava/io/File;

    invoke-virtual {v11}, Ljava/io/File;->getName()Ljava/lang/String;

    move-result-object v11

    invoke-static {v11, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    invoke-static {v10, v11}, Lcom/rokid/security/phone/sdk/server/msg/file/ApkSender;->access$getFileType(Lcom/rokid/security/phone/sdk/server/msg/file/ApkSender;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v10

    .line 92
    .local v10, "fileType":Ljava/lang/String;
    new-instance v11, Lcom/rokid/security/sdk/base/common/apk/FileInfo;

    iget-object v12, v3, Lcom/rokid/security/phone/sdk/server/msg/file/ApkSender$sendFile$3;->$file:Ljava/io/File;

    invoke-virtual {v12}, Ljava/io/File;->getName()Ljava/lang/String;

    move-result-object v12

    invoke-static {v12, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    iget-object v0, v3, Lcom/rokid/security/phone/sdk/server/msg/file/ApkSender$sendFile$3;->$file:Ljava/io/File;

    invoke-virtual {v0}, Ljava/io/File;->length()J

    move-result-wide v13

    invoke-direct {v11, v12, v13, v14, v10}, Lcom/rokid/security/sdk/base/common/apk/FileInfo;-><init>(Ljava/lang/String;JLjava/lang/String;)V

    move-object v0, v11

    .line 93
    .end local v10    # "fileType":Ljava/lang/String;
    .local v0, "fileInfo":Lcom/rokid/security/sdk/base/common/apk/FileInfo;
    iget-object v10, v3, Lcom/rokid/security/phone/sdk/server/msg/file/ApkSender$sendFile$3;->this$0:Lcom/rokid/security/phone/sdk/server/msg/file/ApkSender;

    invoke-static {v10}, Lcom/rokid/security/phone/sdk/server/msg/file/ApkSender;->access$getTAG$p(Lcom/rokid/security/phone/sdk/server/msg/file/ApkSender;)Ljava/lang/String;

    move-result-object v10

    new-instance v11, Ljava/lang/StringBuilder;

    invoke-direct {v11}, Ljava/lang/StringBuilder;-><init>()V

    const-string/jumbo v12, "sendFile "

    invoke-virtual {v11, v12}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v11

    invoke-virtual {v0}, Lcom/rokid/security/sdk/base/common/apk/FileInfo;->getFileName()Ljava/lang/String;

    move-result-object v12

    invoke-virtual {v11, v12}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v11

    const/16 v12, 0x20

    invoke-virtual {v11, v12}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    move-result-object v11

    invoke-virtual {v0}, Lcom/rokid/security/sdk/base/common/apk/FileInfo;->getFileType()Ljava/lang/String;

    move-result-object v13

    invoke-virtual {v11, v13}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v11

    invoke-virtual {v11, v12}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    move-result-object v11

    invoke-virtual {v0}, Lcom/rokid/security/sdk/base/common/apk/FileInfo;->getFileSize()J

    move-result-wide v12

    invoke-virtual {v11, v12, v13}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v11

    invoke-virtual {v11}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v11

    filled-new-array {v11}, [Ljava/lang/Object;

    move-result-object v11

    invoke-static {v10, v11}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->i(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 94
    iget-object v10, v3, Lcom/rokid/security/phone/sdk/server/msg/file/ApkSender$sendFile$3;->this$0:Lcom/rokid/security/phone/sdk/server/msg/file/ApkSender;

    sget-object v11, Lcom/rokid/security/sdk/base/common/apk/Apk3rdUtil;->INSTANCE:Lcom/rokid/security/sdk/base/common/apk/Apk3rdUtil;

    invoke-virtual {v11, v0}, Lcom/rokid/security/sdk/base/common/apk/Apk3rdUtil;->serializeFileInfo(Lcom/rokid/security/sdk/base/common/apk/FileInfo;)[B

    move-result-object v11

    invoke-static {v10, v6, v4, v11}, Lcom/rokid/security/phone/sdk/server/msg/file/ApkSender;->access$sendPacket(Lcom/rokid/security/phone/sdk/server/msg/file/ApkSender;Ljava/io/DataOutputStream;I[B)V

    .line 97
    .end local v0    # "fileInfo":Lcom/rokid/security/sdk/base/common/apk/FileInfo;
    iget-object v0, v3, Lcom/rokid/security/phone/sdk/server/msg/file/ApkSender$sendFile$3;->this$0:Lcom/rokid/security/phone/sdk/server/msg/file/ApkSender;

    invoke-static {v0}, Lcom/rokid/security/phone/sdk/server/msg/file/ApkSender;->access$getBLOCK_SIZE$p(Lcom/rokid/security/phone/sdk/server/msg/file/ApkSender;)I

    move-result v0

    new-array v0, v0, [B

    .line 98
    .local v0, "buffer":[B
    new-instance v10, Lkotlin/jvm/internal/Ref$IntRef;

    invoke-direct {v10}, Lkotlin/jvm/internal/Ref$IntRef;-><init>()V

    .line 99
    .local v10, "bytesRead":Lkotlin/jvm/internal/Ref$IntRef;
    new-instance v11, Lkotlin/jvm/internal/Ref$LongRef;

    invoke-direct {v11}, Lkotlin/jvm/internal/Ref$LongRef;-><init>()V

    .line 100
    .local v11, "totalTransferred":Lkotlin/jvm/internal/Ref$LongRef;
    iget-object v12, v3, Lcom/rokid/security/phone/sdk/server/msg/file/ApkSender$sendFile$3;->$file:Ljava/io/File;

    invoke-virtual {v12}, Ljava/io/File;->length()J

    move-result-wide v12
    :try_end_4
    .catch Ljava/io/IOException; {:try_start_4 .. :try_end_4} :catch_9
    .catchall {:try_start_4 .. :try_end_4} :catchall_9

    .line 101
    .restart local v12    # "fileLength":J
    const-wide/16 v14, 0x0

    move-wide/from16 v23, v14

    move-object v15, v0

    move-object v14, v10

    move-object v0, v11

    move-wide/from16 v10, v23

    move-object/from16 v25, v3

    move-object v3, v1

    move-object/from16 v1, v25

    .line 102
    .end local v3    # "this":Lcom/rokid/security/phone/sdk/server/msg/file/ApkSender$sendFile$3;
    .end local v11    # "totalTransferred":Lkotlin/jvm/internal/Ref$LongRef;
    .local v0, "totalTransferred":Lkotlin/jvm/internal/Ref$LongRef;
    .restart local v1    # "this":Lcom/rokid/security/phone/sdk/server/msg/file/ApkSender$sendFile$3;
    .local v10, "lastProgressTime":J
    .restart local v14    # "bytesRead":Lkotlin/jvm/internal/Ref$IntRef;
    .restart local v15    # "buffer":[B
    :goto_0
    :try_start_5
    invoke-virtual {v9, v15}, Ljava/io/FileInputStream;->read([B)I

    move-result v8

    move/from16 p1, v8

    .line 215
    .local p1, "it":I
    const/16 v16, 0x0

    .line 102
    .local v16, "$i$a$-also-ApkSender$sendFile$3$1":I
    move/from16 v4, p1

    .end local p1    # "it":I
    .local v4, "it":I
    iput v4, v14, Lkotlin/jvm/internal/Ref$IntRef;->element:I
    :try_end_5
    .catch Ljava/io/IOException; {:try_start_5 .. :try_end_5} :catch_8
    .catchall {:try_start_5 .. :try_end_5} :catchall_8

    .end local v4    # "it":I
    .end local v16    # "$i$a$-also-ApkSender$sendFile$3$1":I
    const/4 v4, -0x1

    const/4 v2, 0x2

    if-eq v8, v4, :cond_3

    .line 104
    :try_start_6
    iget v4, v14, Lkotlin/jvm/internal/Ref$IntRef;->element:I

    invoke-static {v15, v4}, Ljava/util/Arrays;->copyOf([BI)[B

    move-result-object v4

    const-string v8, "copyOf(this, newSize)"

    invoke-static {v4, v8}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    .line 107
    .local v4, "dataBlock":[B
    iget-object v8, v1, Lcom/rokid/security/phone/sdk/server/msg/file/ApkSender$sendFile$3;->this$0:Lcom/rokid/security/phone/sdk/server/msg/file/ApkSender;

    invoke-static {v8, v6, v2, v4}, Lcom/rokid/security/phone/sdk/server/msg/file/ApkSender;->access$sendPacket(Lcom/rokid/security/phone/sdk/server/msg/file/ApkSender;Ljava/io/DataOutputStream;I[B)V
    :try_end_6
    .catch Ljava/io/IOException; {:try_start_6 .. :try_end_6} :catch_4
    .catchall {:try_start_6 .. :try_end_6} :catchall_5

    .line 109
    .end local v4    # "dataBlock":[B
    move-object/from16 p1, v5

    .end local v5    # "$result":Ljava/lang/Object;
    .local p1, "$result":Ljava/lang/Object;
    :try_start_7
    iget-wide v4, v0, Lkotlin/jvm/internal/Ref$LongRef;->element:J

    iget v2, v14, Lkotlin/jvm/internal/Ref$IntRef;->element:I
    :try_end_7
    .catch Ljava/io/IOException; {:try_start_7 .. :try_end_7} :catch_3
    .catchall {:try_start_7 .. :try_end_7} :catchall_4

    move-object/from16 v22, v7

    int-to-long v7, v2

    add-long/2addr v4, v7

    :try_start_8
    iput-wide v4, v0, Lkotlin/jvm/internal/Ref$LongRef;->element:J

    .line 111
    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v4

    .line 112
    .local v4, "currentTime":J
    sub-long v7, v4, v10

    iget-object v2, v1, Lcom/rokid/security/phone/sdk/server/msg/file/ApkSender$sendFile$3;->this$0:Lcom/rokid/security/phone/sdk/server/msg/file/ApkSender;

    invoke-static {v2}, Lcom/rokid/security/phone/sdk/server/msg/file/ApkSender;->access$getPROGRESS_INTERVAL_MS$p(Lcom/rokid/security/phone/sdk/server/msg/file/ApkSender;)I

    move-result v2

    move-wide/from16 v16, v10

    .end local v10    # "lastProgressTime":J
    .local v16, "lastProgressTime":J
    int-to-long v10, v2

    cmp-long v2, v7, v10

    if-gez v2, :cond_1

    iget-wide v7, v0, Lkotlin/jvm/internal/Ref$LongRef;->element:J

    cmp-long v2, v7, v12

    if-nez v2, :cond_0

    goto :goto_1

    :cond_0
    move-object/from16 v2, p0

    move-object/from16 v5, p1

    move-wide/from16 v10, v16

    move-object/from16 v7, v22

    const/4 v4, 0x1

    goto :goto_0

    .line 113
    .end local v16    # "lastProgressTime":J
    :cond_1
    :goto_1
    iget-object v2, v1, Lcom/rokid/security/phone/sdk/server/msg/file/ApkSender$sendFile$3;->this$0:Lcom/rokid/security/phone/sdk/server/msg/file/ApkSender;

    invoke-static {v2}, Lcom/rokid/security/phone/sdk/server/msg/file/ApkSender;->access$getTAG$p(Lcom/rokid/security/phone/sdk/server/msg/file/ApkSender;)Ljava/lang/String;

    move-result-object v2

    new-instance v7, Ljava/lang/StringBuilder;

    invoke-direct {v7}, Ljava/lang/StringBuilder;-><init>()V

    const-string/jumbo v8, "\u53d1\u9001\u5269\u4f59 "

    invoke-virtual {v7, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v7

    iget-wide v10, v0, Lkotlin/jvm/internal/Ref$LongRef;->element:J

    sub-long v10, v12, v10

    invoke-virtual {v7, v10, v11}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v7

    invoke-virtual {v7}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v7

    filled-new-array {v7}, [Ljava/lang/Object;

    move-result-object v7

    invoke-static {v2, v7}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->i(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 114
    invoke-static {}, Lkotlinx/coroutines/Dispatchers;->getMain()Lkotlinx/coroutines/MainCoroutineDispatcher;

    move-result-object v2

    check-cast v2, Lkotlin/coroutines/CoroutineContext;

    new-instance v7, Lcom/rokid/security/phone/sdk/server/msg/file/ApkSender$sendFile$3$2;

    iget-object v8, v1, Lcom/rokid/security/phone/sdk/server/msg/file/ApkSender$sendFile$3;->$listener:Lcom/rokid/security/sdk/base/common/apk/TransferProgressListener;

    const/16 v21, 0x0

    move-object/from16 v16, v7

    move-object/from16 v17, v8

    move-object/from16 v18, v0

    move-wide/from16 v19, v12

    invoke-direct/range {v16 .. v21}, Lcom/rokid/security/phone/sdk/server/msg/file/ApkSender$sendFile$3$2;-><init>(Lcom/rokid/security/sdk/base/common/apk/TransferProgressListener;Lkotlin/jvm/internal/Ref$LongRef;JLkotlin/coroutines/Continuation;)V

    check-cast v7, Lkotlin/jvm/functions/Function2;

    move-object v8, v1

    check-cast v8, Lkotlin/coroutines/Continuation;

    iput-object v6, v1, Lcom/rokid/security/phone/sdk/server/msg/file/ApkSender$sendFile$3;->L$0:Ljava/lang/Object;

    iput-object v9, v1, Lcom/rokid/security/phone/sdk/server/msg/file/ApkSender$sendFile$3;->L$1:Ljava/lang/Object;

    iput-object v15, v1, Lcom/rokid/security/phone/sdk/server/msg/file/ApkSender$sendFile$3;->L$2:Ljava/lang/Object;

    iput-object v14, v1, Lcom/rokid/security/phone/sdk/server/msg/file/ApkSender$sendFile$3;->L$3:Ljava/lang/Object;

    iput-object v0, v1, Lcom/rokid/security/phone/sdk/server/msg/file/ApkSender$sendFile$3;->L$4:Ljava/lang/Object;

    iput-wide v12, v1, Lcom/rokid/security/phone/sdk/server/msg/file/ApkSender$sendFile$3;->J$0:J

    iput-wide v4, v1, Lcom/rokid/security/phone/sdk/server/msg/file/ApkSender$sendFile$3;->J$1:J

    const/4 v10, 0x1

    iput v10, v1, Lcom/rokid/security/phone/sdk/server/msg/file/ApkSender$sendFile$3;->label:I

    invoke-static {v2, v7, v8}, Lkotlinx/coroutines/BuildersKt;->withContext(Lkotlin/coroutines/CoroutineContext;Lkotlin/jvm/functions/Function2;Lkotlin/coroutines/Continuation;)Ljava/lang/Object;

    move-result-object v2
    :try_end_8
    .catch Ljava/io/IOException; {:try_start_8 .. :try_end_8} :catch_2
    .catchall {:try_start_8 .. :try_end_8} :catchall_3

    if-ne v2, v3, :cond_2

    .line 81
    return-object v3

    .line 114
    :cond_2
    move-wide v7, v4

    move-object/from16 v5, p1

    .line 117
    .end local v4    # "currentTime":J
    .end local p1    # "$result":Ljava/lang/Object;
    .restart local v5    # "$result":Ljava/lang/Object;
    .local v7, "currentTime":J
    :goto_2
    move-object/from16 v2, p0

    move v4, v10

    move-wide v10, v7

    move-object/from16 v7, v22

    .local v7, "lastProgressTime":J
    goto/16 :goto_0

    .line 145
    .end local v0    # "totalTransferred":Lkotlin/jvm/internal/Ref$LongRef;
    .end local v5    # "$result":Ljava/lang/Object;
    .end local v7    # "lastProgressTime":J
    .end local v12    # "fileLength":J
    .end local v14    # "bytesRead":Lkotlin/jvm/internal/Ref$IntRef;
    .end local v15    # "buffer":[B
    .restart local p1    # "$result":Ljava/lang/Object;
    :catchall_3
    move-exception v0

    move-object/from16 v3, p1

    move-object v2, v0

    move-object v5, v6

    move-object v4, v9

    move-object/from16 v7, v22

    goto/16 :goto_11

    .line 139
    :catch_2
    move-exception v0

    move-object/from16 v5, p1

    move-object v4, v9

    move-object/from16 v7, v22

    goto/16 :goto_b

    .line 145
    :catchall_4
    move-exception v0

    move-object/from16 v22, v7

    move-object/from16 v3, p1

    move-object v2, v0

    move-object v5, v6

    move-object v4, v9

    goto/16 :goto_11

    .line 139
    :catch_3
    move-exception v0

    move-object/from16 v22, v7

    move-object/from16 v5, p1

    move-object v4, v9

    goto/16 :goto_b

    .line 145
    .end local p1    # "$result":Ljava/lang/Object;
    .restart local v5    # "$result":Ljava/lang/Object;
    :catchall_5
    move-exception v0

    move-object/from16 p1, v5

    move-object/from16 v22, v7

    goto/16 :goto_9

    .line 139
    :catch_4
    move-exception v0

    move-object/from16 p1, v5

    move-object/from16 v22, v7

    goto/16 :goto_a

    .line 102
    .restart local v0    # "totalTransferred":Lkotlin/jvm/internal/Ref$LongRef;
    .restart local v10    # "lastProgressTime":J
    .restart local v12    # "fileLength":J
    .restart local v14    # "bytesRead":Lkotlin/jvm/internal/Ref$IntRef;
    .restart local v15    # "buffer":[B
    :cond_3
    move-object/from16 p1, v5

    move-object/from16 v22, v7

    move-wide/from16 v16, v10

    .line 120
    .end local v0    # "totalTransferred":Lkotlin/jvm/internal/Ref$LongRef;
    .end local v5    # "$result":Ljava/lang/Object;
    .end local v10    # "lastProgressTime":J
    .end local v12    # "fileLength":J
    .end local v14    # "bytesRead":Lkotlin/jvm/internal/Ref$IntRef;
    .end local v15    # "buffer":[B
    .restart local p1    # "$result":Ljava/lang/Object;
    :try_start_9
    new-instance v0, Ljava/io/BufferedReader;

    new-instance v4, Ljava/io/InputStreamReader;

    iget-object v5, v1, Lcom/rokid/security/phone/sdk/server/msg/file/ApkSender$sendFile$3;->$socket:Ljava/net/Socket;

    invoke-virtual {v5}, Ljava/net/Socket;->getInputStream()Ljava/io/InputStream;

    move-result-object v5

    invoke-direct {v4, v5}, Ljava/io/InputStreamReader;-><init>(Ljava/io/InputStream;)V

    check-cast v4, Ljava/io/Reader;

    invoke-direct {v0, v4}, Ljava/io/BufferedReader;-><init>(Ljava/io/Reader;)V

    .line 122
    .local v0, "bufferedReader":Ljava/io/BufferedReader;
    iget-object v4, v1, Lcom/rokid/security/phone/sdk/server/msg/file/ApkSender$sendFile$3;->this$0:Lcom/rokid/security/phone/sdk/server/msg/file/ApkSender;

    invoke-static {v4}, Lcom/rokid/security/phone/sdk/server/msg/file/ApkSender;->access$getTAG$p(Lcom/rokid/security/phone/sdk/server/msg/file/ApkSender;)Ljava/lang/String;

    move-result-object v4

    const-string/jumbo v5, "\u6587\u4ef6\u4f20\u5b8c\u7b49Glass3\u56de\u590d... ... "

    filled-new-array {v5}, [Ljava/lang/Object;

    move-result-object v5

    invoke-static {v4, v5}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->i(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 123
    invoke-virtual {v0}, Ljava/io/BufferedReader;->readLine()Ljava/lang/String;

    move-result-object v4

    move-object v0, v4

    .line 124
    .local v0, "message":Ljava/lang/String;
    move-object v4, v0

    check-cast v4, Ljava/lang/CharSequence;

    invoke-static {v4}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v4
    :try_end_9
    .catch Ljava/io/IOException; {:try_start_9 .. :try_end_9} :catch_7
    .catchall {:try_start_9 .. :try_end_9} :catchall_7

    if-nez v4, :cond_7

    .line 125
    :try_start_a
    iget-object v4, v1, Lcom/rokid/security/phone/sdk/server/msg/file/ApkSender$sendFile$3;->this$0:Lcom/rokid/security/phone/sdk/server/msg/file/ApkSender;

    invoke-static {v4}, Lcom/rokid/security/phone/sdk/server/msg/file/ApkSender;->access$getTAG$p(Lcom/rokid/security/phone/sdk/server/msg/file/ApkSender;)Ljava/lang/String;

    move-result-object v4

    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    const-string v7, "Glass3 \u544a\u77e5 "

    invoke-virtual {v5, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v5

    filled-new-array {v5}, [Ljava/lang/Object;

    move-result-object v5

    invoke-static {v4, v5}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->i(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 126
    const-string v4, "message"

    invoke-static {v0, v4}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    const-string/jumbo v4, "success"

    const/4 v5, 0x0

    const/4 v7, 0x0

    invoke-static {v0, v4, v5, v2, v7}, Lkotlin/text/StringsKt;->startsWith$default(Ljava/lang/String;Ljava/lang/String;ZILjava/lang/Object;)Z

    move-result v4

    if-eqz v4, :cond_5

    .line 127
    .end local v0    # "message":Ljava/lang/String;
    invoke-static {}, Lkotlinx/coroutines/Dispatchers;->getMain()Lkotlinx/coroutines/MainCoroutineDispatcher;

    move-result-object v0

    check-cast v0, Lkotlin/coroutines/CoroutineContext;

    new-instance v4, Lcom/rokid/security/phone/sdk/server/msg/file/ApkSender$sendFile$3$3;

    iget-object v5, v1, Lcom/rokid/security/phone/sdk/server/msg/file/ApkSender$sendFile$3;->$listener:Lcom/rokid/security/sdk/base/common/apk/TransferProgressListener;

    const/4 v7, 0x0

    invoke-direct {v4, v5, v7}, Lcom/rokid/security/phone/sdk/server/msg/file/ApkSender$sendFile$3$3;-><init>(Lcom/rokid/security/sdk/base/common/apk/TransferProgressListener;Lkotlin/coroutines/Continuation;)V

    check-cast v4, Lkotlin/jvm/functions/Function2;

    move-object v5, v1

    check-cast v5, Lkotlin/coroutines/Continuation;

    iput-object v6, v1, Lcom/rokid/security/phone/sdk/server/msg/file/ApkSender$sendFile$3;->L$0:Ljava/lang/Object;

    iput-object v9, v1, Lcom/rokid/security/phone/sdk/server/msg/file/ApkSender$sendFile$3;->L$1:Ljava/lang/Object;

    const/4 v7, 0x0

    iput-object v7, v1, Lcom/rokid/security/phone/sdk/server/msg/file/ApkSender$sendFile$3;->L$2:Ljava/lang/Object;

    iput-object v7, v1, Lcom/rokid/security/phone/sdk/server/msg/file/ApkSender$sendFile$3;->L$3:Ljava/lang/Object;

    iput-object v7, v1, Lcom/rokid/security/phone/sdk/server/msg/file/ApkSender$sendFile$3;->L$4:Ljava/lang/Object;

    iput v2, v1, Lcom/rokid/security/phone/sdk/server/msg/file/ApkSender$sendFile$3;->label:I

    invoke-static {v0, v4, v5}, Lkotlinx/coroutines/BuildersKt;->withContext(Lkotlin/coroutines/CoroutineContext;Lkotlin/jvm/functions/Function2;Lkotlin/coroutines/Continuation;)Ljava/lang/Object;

    move-result-object v0

    if-ne v0, v3, :cond_4

    .line 81
    return-object v3

    .line 127
    :cond_4
    move-object/from16 v4, p1

    move-object v10, v6

    move-object/from16 v23, v3

    move-object v3, v1

    move-object/from16 v1, v23

    .end local v1    # "this":Lcom/rokid/security/phone/sdk/server/msg/file/ApkSender$sendFile$3;
    .end local v6    # "dataOut":Ljava/io/DataOutputStream;
    .end local p1    # "$result":Ljava/lang/Object;
    .restart local v3    # "this":Lcom/rokid/security/phone/sdk/server/msg/file/ApkSender$sendFile$3;
    .local v4, "$result":Ljava/lang/Object;
    .local v10, "dataOut":Ljava/io/DataOutputStream;
    :goto_3
    move-object v5, v10

    move-object/from16 v23, v3

    move-object v3, v1

    move-object/from16 v1, v23

    goto :goto_5

    .line 131
    .end local v3    # "this":Lcom/rokid/security/phone/sdk/server/msg/file/ApkSender$sendFile$3;
    .end local v4    # "$result":Ljava/lang/Object;
    .end local v10    # "dataOut":Ljava/io/DataOutputStream;
    .restart local v0    # "message":Ljava/lang/String;
    .restart local v1    # "this":Lcom/rokid/security/phone/sdk/server/msg/file/ApkSender$sendFile$3;
    .restart local v6    # "dataOut":Ljava/io/DataOutputStream;
    .restart local p1    # "$result":Ljava/lang/Object;
    :cond_5
    invoke-static {}, Lkotlinx/coroutines/Dispatchers;->getMain()Lkotlinx/coroutines/MainCoroutineDispatcher;

    move-result-object v2

    check-cast v2, Lkotlin/coroutines/CoroutineContext;

    new-instance v4, Lcom/rokid/security/phone/sdk/server/msg/file/ApkSender$sendFile$3$4;

    iget-object v5, v1, Lcom/rokid/security/phone/sdk/server/msg/file/ApkSender$sendFile$3;->$listener:Lcom/rokid/security/sdk/base/common/apk/TransferProgressListener;

    const/4 v7, 0x0

    invoke-direct {v4, v5, v0, v7}, Lcom/rokid/security/phone/sdk/server/msg/file/ApkSender$sendFile$3$4;-><init>(Lcom/rokid/security/sdk/base/common/apk/TransferProgressListener;Ljava/lang/String;Lkotlin/coroutines/Continuation;)V

    check-cast v4, Lkotlin/jvm/functions/Function2;

    move-object v5, v1

    check-cast v5, Lkotlin/coroutines/Continuation;

    iput-object v6, v1, Lcom/rokid/security/phone/sdk/server/msg/file/ApkSender$sendFile$3;->L$0:Ljava/lang/Object;

    iput-object v9, v1, Lcom/rokid/security/phone/sdk/server/msg/file/ApkSender$sendFile$3;->L$1:Ljava/lang/Object;

    const/4 v7, 0x0

    iput-object v7, v1, Lcom/rokid/security/phone/sdk/server/msg/file/ApkSender$sendFile$3;->L$2:Ljava/lang/Object;

    iput-object v7, v1, Lcom/rokid/security/phone/sdk/server/msg/file/ApkSender$sendFile$3;->L$3:Ljava/lang/Object;

    iput-object v7, v1, Lcom/rokid/security/phone/sdk/server/msg/file/ApkSender$sendFile$3;->L$4:Ljava/lang/Object;

    const/4 v7, 0x3

    iput v7, v1, Lcom/rokid/security/phone/sdk/server/msg/file/ApkSender$sendFile$3;->label:I

    invoke-static {v2, v4, v5}, Lkotlinx/coroutines/BuildersKt;->withContext(Lkotlin/coroutines/CoroutineContext;Lkotlin/jvm/functions/Function2;Lkotlin/coroutines/Continuation;)Ljava/lang/Object;

    move-result-object v2
    :try_end_a
    .catch Ljava/io/IOException; {:try_start_a .. :try_end_a} :catch_2
    .catchall {:try_start_a .. :try_end_a} :catchall_3

    .end local v0    # "message":Ljava/lang/String;
    if-ne v2, v3, :cond_6

    .line 81
    return-object v3

    .line 131
    :cond_6
    move-object/from16 v4, p1

    move-object v10, v6

    move-object/from16 v23, v3

    move-object v3, v1

    move-object/from16 v1, v23

    .line 137
    .end local v1    # "this":Lcom/rokid/security/phone/sdk/server/msg/file/ApkSender$sendFile$3;
    .end local v6    # "dataOut":Ljava/io/DataOutputStream;
    .end local p1    # "$result":Ljava/lang/Object;
    .restart local v3    # "this":Lcom/rokid/security/phone/sdk/server/msg/file/ApkSender$sendFile$3;
    .restart local v4    # "$result":Ljava/lang/Object;
    .restart local v10    # "dataOut":Ljava/io/DataOutputStream;
    :goto_4
    move-object v5, v10

    move-object/from16 v23, v3

    move-object v3, v1

    move-object/from16 v1, v23

    goto :goto_5

    .line 124
    .end local v3    # "this":Lcom/rokid/security/phone/sdk/server/msg/file/ApkSender$sendFile$3;
    .end local v4    # "$result":Ljava/lang/Object;
    .end local v10    # "dataOut":Ljava/io/DataOutputStream;
    .restart local v0    # "message":Ljava/lang/String;
    .restart local v1    # "this":Lcom/rokid/security/phone/sdk/server/msg/file/ApkSender$sendFile$3;
    .restart local v6    # "dataOut":Ljava/io/DataOutputStream;
    .restart local p1    # "$result":Ljava/lang/Object;
    :cond_7
    move-object/from16 v4, p1

    move-object v5, v6

    .line 137
    .end local v0    # "message":Ljava/lang/String;
    .end local v6    # "dataOut":Ljava/io/DataOutputStream;
    .end local p1    # "$result":Ljava/lang/Object;
    .restart local v4    # "$result":Ljava/lang/Object;
    .local v5, "dataOut":Ljava/io/DataOutputStream;
    :goto_5
    :try_start_b
    iget-object v0, v1, Lcom/rokid/security/phone/sdk/server/msg/file/ApkSender$sendFile$3;->this$0:Lcom/rokid/security/phone/sdk/server/msg/file/ApkSender;

    const/4 v2, 0x0

    new-array v2, v2, [B

    const/4 v6, 0x3

    invoke-static {v0, v5, v6, v2}, Lcom/rokid/security/phone/sdk/server/msg/file/ApkSender;->access$sendPacket(Lcom/rokid/security/phone/sdk/server/msg/file/ApkSender;Ljava/io/DataOutputStream;I[B)V

    sget-object v2, Lkotlin/Unit;->INSTANCE:Lkotlin/Unit;
    :try_end_b
    .catch Ljava/io/IOException; {:try_start_b .. :try_end_b} :catch_6
    .catchall {:try_start_b .. :try_end_b} :catchall_6

    .line 145
    nop

    .line 146
    nop

    .end local v9    # "fileIn":Ljava/io/FileInputStream;
    if-eqz v9, :cond_8

    :try_start_c
    invoke-virtual {v9}, Ljava/io/FileInputStream;->close()V

    goto :goto_6

    .line 149
    .end local v5    # "dataOut":Ljava/io/DataOutputStream;
    :catch_5
    move-exception v0

    goto :goto_7

    .line 147
    .restart local v5    # "dataOut":Ljava/io/DataOutputStream;
    :cond_8
    :goto_6
    nop

    .end local v5    # "dataOut":Ljava/io/DataOutputStream;
    if-eqz v5, :cond_9

    invoke-virtual {v5}, Ljava/io/DataOutputStream;->close()V

    .line 148
    :cond_9
    iget-object v0, v1, Lcom/rokid/security/phone/sdk/server/msg/file/ApkSender$sendFile$3;->$socket:Ljava/net/Socket;

    invoke-virtual {v0}, Ljava/net/Socket;->close()V
    :try_end_c
    .catch Ljava/io/IOException; {:try_start_c .. :try_end_c} :catch_5

    goto :goto_8

    .line 150
    .local v0, "e":Ljava/io/IOException;
    :goto_7
    iget-object v3, v1, Lcom/rokid/security/phone/sdk/server/msg/file/ApkSender$sendFile$3;->this$0:Lcom/rokid/security/phone/sdk/server/msg/file/ApkSender;

    invoke-static {v3}, Lcom/rokid/security/phone/sdk/server/msg/file/ApkSender;->access$getTAG$p(Lcom/rokid/security/phone/sdk/server/msg/file/ApkSender;)Ljava/lang/String;

    move-result-object v3

    move-object/from16 v7, v22

    filled-new-array {v7, v0}, [Ljava/lang/Object;

    move-result-object v5

    invoke-static {v3, v5}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->e(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 152
    .end local v0    # "e":Ljava/io/IOException;
    :goto_8
    goto/16 :goto_10

    .line 145
    .restart local v5    # "dataOut":Ljava/io/DataOutputStream;
    .restart local v9    # "fileIn":Ljava/io/FileInputStream;
    :catchall_6
    move-exception v0

    move-object/from16 v7, v22

    move-object v2, v0

    move-object v3, v4

    move-object v4, v9

    goto/16 :goto_11

    .line 139
    :catch_6
    move-exception v0

    move-object/from16 v7, v22

    move-object v6, v5

    move-object v5, v4

    move-object v4, v9

    goto :goto_b

    .line 145
    .end local v4    # "$result":Ljava/lang/Object;
    .end local v5    # "dataOut":Ljava/io/DataOutputStream;
    .restart local v6    # "dataOut":Ljava/io/DataOutputStream;
    .restart local p1    # "$result":Ljava/lang/Object;
    :catchall_7
    move-exception v0

    move-object/from16 v7, v22

    move-object/from16 v3, p1

    move-object v2, v0

    move-object v5, v6

    move-object v4, v9

    goto/16 :goto_11

    .line 139
    :catch_7
    move-exception v0

    move-object/from16 v7, v22

    move-object/from16 v5, p1

    move-object v4, v9

    goto :goto_b

    .line 145
    .end local p1    # "$result":Ljava/lang/Object;
    .local v5, "$result":Ljava/lang/Object;
    :catchall_8
    move-exception v0

    move-object/from16 p1, v5

    :goto_9
    move-object/from16 v3, p1

    move-object v2, v0

    move-object v5, v6

    move-object v4, v9

    .end local v5    # "$result":Ljava/lang/Object;
    .restart local p1    # "$result":Ljava/lang/Object;
    goto/16 :goto_11

    .line 139
    .end local p1    # "$result":Ljava/lang/Object;
    .restart local v5    # "$result":Ljava/lang/Object;
    :catch_8
    move-exception v0

    move-object/from16 p1, v5

    :goto_a
    move-object v4, v9

    .end local v5    # "$result":Ljava/lang/Object;
    .restart local p1    # "$result":Ljava/lang/Object;
    goto :goto_b

    .line 145
    .end local v1    # "this":Lcom/rokid/security/phone/sdk/server/msg/file/ApkSender$sendFile$3;
    .end local p1    # "$result":Ljava/lang/Object;
    .restart local v3    # "this":Lcom/rokid/security/phone/sdk/server/msg/file/ApkSender$sendFile$3;
    .restart local v5    # "$result":Ljava/lang/Object;
    :catchall_9
    move-exception v0

    move-object v2, v0

    move-object v1, v3

    move-object v3, v5

    move-object v5, v6

    move-object v4, v9

    goto/16 :goto_11

    .line 139
    :catch_9
    move-exception v0

    move-object v4, v9

    move-object/from16 v23, v3

    move-object v3, v1

    move-object/from16 v1, v23

    .line 140
    .end local v3    # "this":Lcom/rokid/security/phone/sdk/server/msg/file/ApkSender$sendFile$3;
    .end local v9    # "fileIn":Ljava/io/FileInputStream;
    .restart local v0    # "e":Ljava/io/IOException;
    .restart local v1    # "this":Lcom/rokid/security/phone/sdk/server/msg/file/ApkSender$sendFile$3;
    .local v4, "fileIn":Ljava/io/FileInputStream;
    :goto_b
    :try_start_d
    iget-object v2, v1, Lcom/rokid/security/phone/sdk/server/msg/file/ApkSender$sendFile$3;->this$0:Lcom/rokid/security/phone/sdk/server/msg/file/ApkSender;

    invoke-static {v2}, Lcom/rokid/security/phone/sdk/server/msg/file/ApkSender;->access$getTAG$p(Lcom/rokid/security/phone/sdk/server/msg/file/ApkSender;)Ljava/lang/String;

    move-result-object v2

    const-string/jumbo v8, "\u53d1\u9001\u6587\u4ef6\u51fa\u9519"

    filled-new-array {v8, v0}, [Ljava/lang/Object;

    move-result-object v8

    invoke-static {v2, v8}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->e(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 141
    invoke-static {}, Lkotlinx/coroutines/Dispatchers;->getMain()Lkotlinx/coroutines/MainCoroutineDispatcher;

    move-result-object v2

    check-cast v2, Lkotlin/coroutines/CoroutineContext;

    new-instance v8, Lcom/rokid/security/phone/sdk/server/msg/file/ApkSender$sendFile$3$5;

    iget-object v9, v1, Lcom/rokid/security/phone/sdk/server/msg/file/ApkSender$sendFile$3;->$listener:Lcom/rokid/security/sdk/base/common/apk/TransferProgressListener;

    const/4 v10, 0x0

    invoke-direct {v8, v9, v0, v10}, Lcom/rokid/security/phone/sdk/server/msg/file/ApkSender$sendFile$3$5;-><init>(Lcom/rokid/security/sdk/base/common/apk/TransferProgressListener;Ljava/io/IOException;Lkotlin/coroutines/Continuation;)V

    check-cast v8, Lkotlin/jvm/functions/Function2;

    move-object v9, v1

    check-cast v9, Lkotlin/coroutines/Continuation;

    iput-object v6, v1, Lcom/rokid/security/phone/sdk/server/msg/file/ApkSender$sendFile$3;->L$0:Ljava/lang/Object;

    iput-object v4, v1, Lcom/rokid/security/phone/sdk/server/msg/file/ApkSender$sendFile$3;->L$1:Ljava/lang/Object;

    const/4 v10, 0x0

    iput-object v10, v1, Lcom/rokid/security/phone/sdk/server/msg/file/ApkSender$sendFile$3;->L$2:Ljava/lang/Object;

    iput-object v10, v1, Lcom/rokid/security/phone/sdk/server/msg/file/ApkSender$sendFile$3;->L$3:Ljava/lang/Object;

    iput-object v10, v1, Lcom/rokid/security/phone/sdk/server/msg/file/ApkSender$sendFile$3;->L$4:Ljava/lang/Object;

    const/4 v10, 0x4

    iput v10, v1, Lcom/rokid/security/phone/sdk/server/msg/file/ApkSender$sendFile$3;->label:I

    invoke-static {v2, v8, v9}, Lkotlinx/coroutines/BuildersKt;->withContext(Lkotlin/coroutines/CoroutineContext;Lkotlin/jvm/functions/Function2;Lkotlin/coroutines/Continuation;)Ljava/lang/Object;

    move-result-object v2

    .end local v0    # "e":Ljava/io/IOException;
    if-ne v2, v3, :cond_a

    .line 81
    return-object v3

    .line 141
    :cond_a
    move-object v3, v2

    .line 81
    :goto_c
    move-object v2, v3

    check-cast v2, Lkotlin/Unit;
    :try_end_d
    .catchall {:try_start_d .. :try_end_d} :catchall_a

    .line 145
    nop

    .line 146
    nop

    .end local v4    # "fileIn":Ljava/io/FileInputStream;
    if-eqz v4, :cond_b

    :try_start_e
    invoke-virtual {v4}, Ljava/io/FileInputStream;->close()V

    goto :goto_d

    .line 149
    .end local v6    # "dataOut":Ljava/io/DataOutputStream;
    :catch_a
    move-exception v0

    goto :goto_e

    .line 147
    .restart local v6    # "dataOut":Ljava/io/DataOutputStream;
    :cond_b
    :goto_d
    nop

    .end local v6    # "dataOut":Ljava/io/DataOutputStream;
    if-eqz v6, :cond_c

    invoke-virtual {v6}, Ljava/io/DataOutputStream;->close()V

    .line 148
    :cond_c
    iget-object v0, v1, Lcom/rokid/security/phone/sdk/server/msg/file/ApkSender$sendFile$3;->$socket:Ljava/net/Socket;

    invoke-virtual {v0}, Ljava/net/Socket;->close()V
    :try_end_e
    .catch Ljava/io/IOException; {:try_start_e .. :try_end_e} :catch_a

    goto :goto_f

    .line 150
    .restart local v0    # "e":Ljava/io/IOException;
    :goto_e
    iget-object v3, v1, Lcom/rokid/security/phone/sdk/server/msg/file/ApkSender$sendFile$3;->this$0:Lcom/rokid/security/phone/sdk/server/msg/file/ApkSender;

    invoke-static {v3}, Lcom/rokid/security/phone/sdk/server/msg/file/ApkSender;->access$getTAG$p(Lcom/rokid/security/phone/sdk/server/msg/file/ApkSender;)Ljava/lang/String;

    move-result-object v3

    filled-new-array {v7, v0}, [Ljava/lang/Object;

    move-result-object v4

    invoke-static {v3, v4}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->e(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 152
    .end local v0    # "e":Ljava/io/IOException;
    :goto_f
    move-object v4, v5

    .line 85
    .end local v5    # "$result":Ljava/lang/Object;
    .local v4, "$result":Ljava/lang/Object;
    :goto_10
    return-object v2

    .line 145
    .local v4, "fileIn":Ljava/io/FileInputStream;
    .restart local v5    # "$result":Ljava/lang/Object;
    .restart local v6    # "dataOut":Ljava/io/DataOutputStream;
    :catchall_a
    move-exception v0

    move-object v2, v0

    move-object v3, v5

    move-object v5, v6

    .line 146
    .end local v6    # "dataOut":Ljava/io/DataOutputStream;
    .local v3, "$result":Ljava/lang/Object;
    .local v5, "dataOut":Ljava/io/DataOutputStream;
    :goto_11
    nop

    .end local v4    # "fileIn":Ljava/io/FileInputStream;
    if-eqz v4, :cond_d

    :try_start_f
    invoke-virtual {v4}, Ljava/io/FileInputStream;->close()V

    goto :goto_12

    .line 149
    .end local v5    # "dataOut":Ljava/io/DataOutputStream;
    :catch_b
    move-exception v0

    goto :goto_13

    .line 147
    .restart local v5    # "dataOut":Ljava/io/DataOutputStream;
    :cond_d
    :goto_12
    nop

    .end local v5    # "dataOut":Ljava/io/DataOutputStream;
    if-eqz v5, :cond_e

    invoke-virtual {v5}, Ljava/io/DataOutputStream;->close()V

    .line 148
    :cond_e
    iget-object v0, v1, Lcom/rokid/security/phone/sdk/server/msg/file/ApkSender$sendFile$3;->$socket:Ljava/net/Socket;

    invoke-virtual {v0}, Ljava/net/Socket;->close()V
    :try_end_f
    .catch Ljava/io/IOException; {:try_start_f .. :try_end_f} :catch_b

    goto :goto_14

    .line 150
    .restart local v0    # "e":Ljava/io/IOException;
    :goto_13
    iget-object v4, v1, Lcom/rokid/security/phone/sdk/server/msg/file/ApkSender$sendFile$3;->this$0:Lcom/rokid/security/phone/sdk/server/msg/file/ApkSender;

    invoke-static {v4}, Lcom/rokid/security/phone/sdk/server/msg/file/ApkSender;->access$getTAG$p(Lcom/rokid/security/phone/sdk/server/msg/file/ApkSender;)Ljava/lang/String;

    move-result-object v4

    filled-new-array {v7, v0}, [Ljava/lang/Object;

    move-result-object v5

    invoke-static {v4, v5}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->e(Ljava/lang/String;[Ljava/lang/Object;)V

    .end local v0    # "e":Ljava/io/IOException;
    :goto_14
    throw v2

    :pswitch_data_0
    .packed-switch 0x0
        :pswitch_4
        :pswitch_3
        :pswitch_2
        :pswitch_1
        :pswitch_0
    .end packed-switch
.end method
