.class final Lcom/rokid/security/phone/sdk/server/msg/file/FileSender$sendFile$2;
.super Lkotlin/coroutines/jvm/internal/SuspendLambda;
.source "FileSender.kt"

# interfaces
.implements Lkotlin/jvm/functions/Function2;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/rokid/security/phone/sdk/server/msg/file/FileSender;->sendFile(Ljava/lang/String;Ljava/lang/String;Ljava/io/File;Lcom/rokid/security/phone/sdk/api/msg/listener/FileReceiveListener;Lkotlin/jvm/functions/Function1;)V
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
    value = "SMAP\nFileSender.kt\nKotlin\n*S Kotlin\n*F\n+ 1 FileSender.kt\ncom/rokid/security/phone/sdk/server/msg/file/FileSender$sendFile$2\n+ 2 fake.kt\nkotlin/jvm/internal/FakeKt\n*L\n1#1,204:1\n1#2:205\n*E\n"
.end annotation

.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000\n\n\u0000\n\u0002\u0010\u0002\n\u0002\u0018\u0002\u0010\u0000\u001a\u00020\u0001*\u00020\u0002H\u008a@"
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
    c = "com.rokid.security.phone.sdk.server.msg.file.FileSender$sendFile$2"
    f = "FileSender.kt"
    i = {
        0x0,
        0x1,
        0x2,
        0x2,
        0x2,
        0x2,
        0x2,
        0x2,
        0x2,
        0x3,
        0x3,
        0x3,
        0x3,
        0x3,
        0x3,
        0x3
    }
    l = {
        0x3e,
        0x43,
        0x5e,
        0x6d,
        0x76,
        0x7d
    }
    m = "invokeSuspend"
    n = {
        "$this$launch",
        "$this$launch",
        "$this$launch",
        "fileInputStream",
        "buffer",
        "bytesRead",
        "totalBytesRead",
        "fileLength",
        "lastProgress",
        "$this$launch",
        "fileInputStream",
        "buffer",
        "bytesRead",
        "totalBytesRead",
        "fileLength",
        "currentProgress"
    }
    s = {
        "L$0",
        "L$0",
        "L$0",
        "L$5",
        "L$6",
        "L$7",
        "L$8",
        "J$0",
        "F$0",
        "L$0",
        "L$5",
        "L$6",
        "L$7",
        "L$8",
        "J$0",
        "F$0"
    }
.end annotation


# instance fields
.field final synthetic $appListener:Lcom/rokid/security/phone/sdk/api/msg/listener/FileReceiveListener;

.field final synthetic $dir:Ljava/lang/String;

.field final synthetic $file:Ljava/io/File;

.field final synthetic $host:Ljava/lang/String;

.field final synthetic $onResult:Lkotlin/jvm/functions/Function1;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Lkotlin/jvm/functions/Function1<",
            "Lcom/rokid/security/phone/sdk/base/data/callback/IResult<",
            "Ljava/lang/Boolean;",
            ">;",
            "Lkotlin/Unit;",
            ">;"
        }
    .end annotation
.end field

.field F$0:F

.field J$0:J

.field private synthetic L$0:Ljava/lang/Object;

.field L$1:Ljava/lang/Object;

.field L$2:Ljava/lang/Object;

.field L$3:Ljava/lang/Object;

.field L$4:Ljava/lang/Object;

.field L$5:Ljava/lang/Object;

.field L$6:Ljava/lang/Object;

.field L$7:Ljava/lang/Object;

.field L$8:Ljava/lang/Object;

.field label:I

.field final synthetic this$0:Lcom/rokid/security/phone/sdk/server/msg/file/FileSender;


# direct methods
.method constructor <init>(Lcom/rokid/security/phone/sdk/server/msg/file/FileSender;Ljava/lang/String;Lcom/rokid/security/phone/sdk/api/msg/listener/FileReceiveListener;Lkotlin/jvm/functions/Function1;Ljava/io/File;Ljava/lang/String;Lkotlin/coroutines/Continuation;)V
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lcom/rokid/security/phone/sdk/server/msg/file/FileSender;",
            "Ljava/lang/String;",
            "Lcom/rokid/security/phone/sdk/api/msg/listener/FileReceiveListener;",
            "Lkotlin/jvm/functions/Function1<",
            "-",
            "Lcom/rokid/security/phone/sdk/base/data/callback/IResult<",
            "Ljava/lang/Boolean;",
            ">;",
            "Lkotlin/Unit;",
            ">;",
            "Ljava/io/File;",
            "Ljava/lang/String;",
            "Lkotlin/coroutines/Continuation<",
            "-",
            "Lcom/rokid/security/phone/sdk/server/msg/file/FileSender$sendFile$2;",
            ">;)V"
        }
    .end annotation

    iput-object p1, p0, Lcom/rokid/security/phone/sdk/server/msg/file/FileSender$sendFile$2;->this$0:Lcom/rokid/security/phone/sdk/server/msg/file/FileSender;

    iput-object p2, p0, Lcom/rokid/security/phone/sdk/server/msg/file/FileSender$sendFile$2;->$host:Ljava/lang/String;

    iput-object p3, p0, Lcom/rokid/security/phone/sdk/server/msg/file/FileSender$sendFile$2;->$appListener:Lcom/rokid/security/phone/sdk/api/msg/listener/FileReceiveListener;

    iput-object p4, p0, Lcom/rokid/security/phone/sdk/server/msg/file/FileSender$sendFile$2;->$onResult:Lkotlin/jvm/functions/Function1;

    iput-object p5, p0, Lcom/rokid/security/phone/sdk/server/msg/file/FileSender$sendFile$2;->$file:Ljava/io/File;

    iput-object p6, p0, Lcom/rokid/security/phone/sdk/server/msg/file/FileSender$sendFile$2;->$dir:Ljava/lang/String;

    const/4 v0, 0x2

    invoke-direct {p0, v0, p7}, Lkotlin/coroutines/jvm/internal/SuspendLambda;-><init>(ILkotlin/coroutines/Continuation;)V

    return-void
.end method


# virtual methods
.method public final create(Ljava/lang/Object;Lkotlin/coroutines/Continuation;)Lkotlin/coroutines/Continuation;
    .locals 9
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

    new-instance v8, Lcom/rokid/security/phone/sdk/server/msg/file/FileSender$sendFile$2;

    iget-object v1, p0, Lcom/rokid/security/phone/sdk/server/msg/file/FileSender$sendFile$2;->this$0:Lcom/rokid/security/phone/sdk/server/msg/file/FileSender;

    iget-object v2, p0, Lcom/rokid/security/phone/sdk/server/msg/file/FileSender$sendFile$2;->$host:Ljava/lang/String;

    iget-object v3, p0, Lcom/rokid/security/phone/sdk/server/msg/file/FileSender$sendFile$2;->$appListener:Lcom/rokid/security/phone/sdk/api/msg/listener/FileReceiveListener;

    iget-object v4, p0, Lcom/rokid/security/phone/sdk/server/msg/file/FileSender$sendFile$2;->$onResult:Lkotlin/jvm/functions/Function1;

    iget-object v5, p0, Lcom/rokid/security/phone/sdk/server/msg/file/FileSender$sendFile$2;->$file:Ljava/io/File;

    iget-object v6, p0, Lcom/rokid/security/phone/sdk/server/msg/file/FileSender$sendFile$2;->$dir:Ljava/lang/String;

    move-object v0, v8

    move-object v7, p2

    invoke-direct/range {v0 .. v7}, Lcom/rokid/security/phone/sdk/server/msg/file/FileSender$sendFile$2;-><init>(Lcom/rokid/security/phone/sdk/server/msg/file/FileSender;Ljava/lang/String;Lcom/rokid/security/phone/sdk/api/msg/listener/FileReceiveListener;Lkotlin/jvm/functions/Function1;Ljava/io/File;Ljava/lang/String;Lkotlin/coroutines/Continuation;)V

    iput-object p1, v8, Lcom/rokid/security/phone/sdk/server/msg/file/FileSender$sendFile$2;->L$0:Ljava/lang/Object;

    check-cast v8, Lkotlin/coroutines/Continuation;

    return-object v8
.end method

.method public bridge synthetic invoke(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;
    .locals 1

    check-cast p1, Lkotlinx/coroutines/CoroutineScope;

    check-cast p2, Lkotlin/coroutines/Continuation;

    invoke-virtual {p0, p1, p2}, Lcom/rokid/security/phone/sdk/server/msg/file/FileSender$sendFile$2;->invoke(Lkotlinx/coroutines/CoroutineScope;Lkotlin/coroutines/Continuation;)Ljava/lang/Object;

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

    invoke-virtual {p0, p1, p2}, Lcom/rokid/security/phone/sdk/server/msg/file/FileSender$sendFile$2;->create(Ljava/lang/Object;Lkotlin/coroutines/Continuation;)Lkotlin/coroutines/Continuation;

    move-result-object v0

    check-cast v0, Lcom/rokid/security/phone/sdk/server/msg/file/FileSender$sendFile$2;

    sget-object v1, Lkotlin/Unit;->INSTANCE:Lkotlin/Unit;

    invoke-virtual {v0, v1}, Lcom/rokid/security/phone/sdk/server/msg/file/FileSender$sendFile$2;->invokeSuspend(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    return-object v0
.end method

.method public final invokeSuspend(Ljava/lang/Object;)Ljava/lang/Object;
    .locals 35

    invoke-static {}, Lkotlin/coroutines/intrinsics/IntrinsicsKt;->getCOROUTINE_SUSPENDED()Ljava/lang/Object;

    move-result-object v1

    .line 59
    move-object/from16 v2, p0

    iget v0, v2, Lcom/rokid/security/phone/sdk/server/msg/file/FileSender$sendFile$2;->label:I

    const/4 v3, 0x2

    const/4 v4, 0x1

    packed-switch v0, :pswitch_data_0

    new-instance v0, Ljava/lang/IllegalStateException;

    const-string v1, "call to \'resume\' before \'invoke\' with coroutine"

    invoke-direct {v0, v1}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/String;)V

    throw v0

    :pswitch_0
    move-object/from16 v1, p0

    .local v1, "this":Lcom/rokid/security/phone/sdk/server/msg/file/FileSender$sendFile$2;
    move-object/from16 v3, p1

    .local v3, "$result":Ljava/lang/Object;
    :try_start_0
    invoke-static {v3}, Lkotlin/ResultKt;->throwOnFailure(Ljava/lang/Object;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    goto/16 :goto_e

    .line 130
    :catchall_0
    move-exception v0

    goto/16 :goto_f

    .line 59
    .end local v1    # "this":Lcom/rokid/security/phone/sdk/server/msg/file/FileSender$sendFile$2;
    .end local v3    # "$result":Ljava/lang/Object;
    :pswitch_1
    move-object/from16 v3, p0

    .local v3, "this":Lcom/rokid/security/phone/sdk/server/msg/file/FileSender$sendFile$2;
    move-object/from16 v4, p1

    .local v4, "$result":Ljava/lang/Object;
    const/4 v0, 0x0

    .local v0, "$i$a$-use-FileSender$sendFile$2$2":I
    iget-object v5, v3, Lcom/rokid/security/phone/sdk/server/msg/file/FileSender$sendFile$2;->L$0:Ljava/lang/Object;

    check-cast v5, Ljava/io/Closeable;

    :try_start_1
    invoke-static {v4}, Lkotlin/ResultKt;->throwOnFailure(Ljava/lang/Object;)V
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_1

    move-object v13, v1

    move-object v1, v3

    move-object v3, v4

    const/4 v11, 0x0

    goto/16 :goto_b

    .line 72
    .end local v0    # "$i$a$-use-FileSender$sendFile$2$2":I
    :catchall_1
    move-exception v0

    move-object v2, v0

    move-object v13, v1

    move-object v1, v3

    move-object v3, v4

    goto/16 :goto_c

    .line 59
    .end local v3    # "this":Lcom/rokid/security/phone/sdk/server/msg/file/FileSender$sendFile$2;
    .end local v4    # "$result":Ljava/lang/Object;
    :pswitch_2
    move-object/from16 v3, p0

    .restart local v3    # "this":Lcom/rokid/security/phone/sdk/server/msg/file/FileSender$sendFile$2;
    move-object/from16 v4, p1

    .restart local v4    # "$result":Ljava/lang/Object;
    const/4 v0, 0x0

    .restart local v0    # "$i$a$-use-FileSender$sendFile$2$2":I
    iget v7, v3, Lcom/rokid/security/phone/sdk/server/msg/file/FileSender$sendFile$2;->F$0:F

    .local v7, "currentProgress":F
    iget-wide v8, v3, Lcom/rokid/security/phone/sdk/server/msg/file/FileSender$sendFile$2;->J$0:J

    .local v8, "fileLength":J
    iget-object v10, v3, Lcom/rokid/security/phone/sdk/server/msg/file/FileSender$sendFile$2;->L$8:Ljava/lang/Object;

    check-cast v10, Lkotlin/jvm/internal/Ref$LongRef;

    .local v10, "totalBytesRead":Lkotlin/jvm/internal/Ref$LongRef;
    iget-object v11, v3, Lcom/rokid/security/phone/sdk/server/msg/file/FileSender$sendFile$2;->L$7:Ljava/lang/Object;

    check-cast v11, Lkotlin/jvm/internal/Ref$IntRef;

    .local v11, "bytesRead":Lkotlin/jvm/internal/Ref$IntRef;
    iget-object v12, v3, Lcom/rokid/security/phone/sdk/server/msg/file/FileSender$sendFile$2;->L$6:Ljava/lang/Object;

    check-cast v12, [B

    .local v12, "buffer":[B
    iget-object v13, v3, Lcom/rokid/security/phone/sdk/server/msg/file/FileSender$sendFile$2;->L$5:Ljava/lang/Object;

    check-cast v13, Ljava/io/FileInputStream;

    .local v13, "fileInputStream":Ljava/io/FileInputStream;
    iget-object v14, v3, Lcom/rokid/security/phone/sdk/server/msg/file/FileSender$sendFile$2;->L$4:Ljava/lang/Object;

    check-cast v14, Lkotlin/jvm/functions/Function1;

    iget-object v15, v3, Lcom/rokid/security/phone/sdk/server/msg/file/FileSender$sendFile$2;->L$3:Ljava/lang/Object;

    check-cast v15, Lcom/rokid/security/phone/sdk/api/msg/listener/FileReceiveListener;

    iget-object v5, v3, Lcom/rokid/security/phone/sdk/server/msg/file/FileSender$sendFile$2;->L$2:Ljava/lang/Object;

    check-cast v5, Lcom/rokid/security/phone/sdk/server/msg/file/FileSender;

    iget-object v6, v3, Lcom/rokid/security/phone/sdk/server/msg/file/FileSender$sendFile$2;->L$1:Ljava/lang/Object;

    check-cast v6, Ljava/io/Closeable;

    move/from16 p1, v0

    .end local v0    # "$i$a$-use-FileSender$sendFile$2$2":I
    .local p1, "$i$a$-use-FileSender$sendFile$2$2":I
    iget-object v0, v3, Lcom/rokid/security/phone/sdk/server/msg/file/FileSender$sendFile$2;->L$0:Ljava/lang/Object;

    check-cast v0, Lkotlinx/coroutines/CoroutineScope;

    .local v0, "$this$launch":Lkotlinx/coroutines/CoroutineScope;
    :try_start_2
    invoke-static {v4}, Lkotlin/ResultKt;->throwOnFailure(Ljava/lang/Object;)V
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_2

    move/from16 v24, p1

    move-object/from16 v23, v4

    move-object v2, v6

    const/16 v16, 0x0

    move-object/from16 v33, v14

    move-object v14, v5

    move-wide v4, v8

    move-object v9, v11

    move-object v8, v12

    move-object v11, v10

    move-object/from16 v10, v33

    goto/16 :goto_a

    .line 72
    .end local v0    # "$this$launch":Lkotlinx/coroutines/CoroutineScope;
    .end local v7    # "currentProgress":F
    .end local v8    # "fileLength":J
    .end local v10    # "totalBytesRead":Lkotlin/jvm/internal/Ref$LongRef;
    .end local v11    # "bytesRead":Lkotlin/jvm/internal/Ref$IntRef;
    .end local v12    # "buffer":[B
    .end local v13    # "fileInputStream":Ljava/io/FileInputStream;
    .end local p1    # "$i$a$-use-FileSender$sendFile$2$2":I
    :catchall_2
    move-exception v0

    move-object v2, v0

    move-object v13, v1

    move-object v1, v3

    move-object v3, v4

    move-object v5, v6

    goto/16 :goto_c

    .line 59
    .end local v3    # "this":Lcom/rokid/security/phone/sdk/server/msg/file/FileSender$sendFile$2;
    .end local v4    # "$result":Ljava/lang/Object;
    :pswitch_3
    move-object/from16 v3, p0

    .restart local v3    # "this":Lcom/rokid/security/phone/sdk/server/msg/file/FileSender$sendFile$2;
    move-object/from16 v4, p1

    .restart local v4    # "$result":Ljava/lang/Object;
    const/4 v0, 0x0

    .local v0, "$i$a$-use-FileSender$sendFile$2$2":I
    iget v5, v3, Lcom/rokid/security/phone/sdk/server/msg/file/FileSender$sendFile$2;->F$0:F

    .local v5, "lastProgress":F
    iget-wide v6, v3, Lcom/rokid/security/phone/sdk/server/msg/file/FileSender$sendFile$2;->J$0:J

    .local v6, "fileLength":J
    iget-object v8, v3, Lcom/rokid/security/phone/sdk/server/msg/file/FileSender$sendFile$2;->L$8:Ljava/lang/Object;

    check-cast v8, Lkotlin/jvm/internal/Ref$LongRef;

    .local v8, "totalBytesRead":Lkotlin/jvm/internal/Ref$LongRef;
    iget-object v9, v3, Lcom/rokid/security/phone/sdk/server/msg/file/FileSender$sendFile$2;->L$7:Ljava/lang/Object;

    check-cast v9, Lkotlin/jvm/internal/Ref$IntRef;

    .local v9, "bytesRead":Lkotlin/jvm/internal/Ref$IntRef;
    iget-object v10, v3, Lcom/rokid/security/phone/sdk/server/msg/file/FileSender$sendFile$2;->L$6:Ljava/lang/Object;

    check-cast v10, [B

    .local v10, "buffer":[B
    iget-object v11, v3, Lcom/rokid/security/phone/sdk/server/msg/file/FileSender$sendFile$2;->L$5:Ljava/lang/Object;

    check-cast v11, Ljava/io/FileInputStream;

    .local v11, "fileInputStream":Ljava/io/FileInputStream;
    iget-object v12, v3, Lcom/rokid/security/phone/sdk/server/msg/file/FileSender$sendFile$2;->L$4:Ljava/lang/Object;

    check-cast v12, Lkotlin/jvm/functions/Function1;

    iget-object v13, v3, Lcom/rokid/security/phone/sdk/server/msg/file/FileSender$sendFile$2;->L$3:Ljava/lang/Object;

    check-cast v13, Lcom/rokid/security/phone/sdk/api/msg/listener/FileReceiveListener;

    iget-object v14, v3, Lcom/rokid/security/phone/sdk/server/msg/file/FileSender$sendFile$2;->L$2:Ljava/lang/Object;

    check-cast v14, Lcom/rokid/security/phone/sdk/server/msg/file/FileSender;

    iget-object v15, v3, Lcom/rokid/security/phone/sdk/server/msg/file/FileSender$sendFile$2;->L$1:Ljava/lang/Object;

    check-cast v15, Ljava/io/Closeable;

    move/from16 p1, v0

    .end local v0    # "$i$a$-use-FileSender$sendFile$2$2":I
    .restart local p1    # "$i$a$-use-FileSender$sendFile$2$2":I
    iget-object v0, v3, Lcom/rokid/security/phone/sdk/server/msg/file/FileSender$sendFile$2;->L$0:Ljava/lang/Object;

    check-cast v0, Lkotlinx/coroutines/CoroutineScope;

    .local v0, "$this$launch":Lkotlinx/coroutines/CoroutineScope;
    :try_start_3
    invoke-static {v4}, Lkotlin/ResultKt;->throwOnFailure(Ljava/lang/Object;)V
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_3

    move/from16 v24, p1

    move-object/from16 v33, v9

    move-object v9, v1

    move-object v1, v15

    move-object v15, v10

    move-object/from16 v10, v33

    goto/16 :goto_7

    .line 72
    .end local v0    # "$this$launch":Lkotlinx/coroutines/CoroutineScope;
    .end local v5    # "lastProgress":F
    .end local v6    # "fileLength":J
    .end local v8    # "totalBytesRead":Lkotlin/jvm/internal/Ref$LongRef;
    .end local v9    # "bytesRead":Lkotlin/jvm/internal/Ref$IntRef;
    .end local v10    # "buffer":[B
    .end local v11    # "fileInputStream":Ljava/io/FileInputStream;
    .end local p1    # "$i$a$-use-FileSender$sendFile$2$2":I
    :catchall_3
    move-exception v0

    move-object v2, v0

    move-object v13, v1

    move-object v1, v3

    move-object v3, v4

    move-object v5, v15

    goto/16 :goto_c

    .line 59
    .end local v3    # "this":Lcom/rokid/security/phone/sdk/server/msg/file/FileSender$sendFile$2;
    .end local v4    # "$result":Ljava/lang/Object;
    :pswitch_4
    move-object/from16 v5, p0

    .local v5, "this":Lcom/rokid/security/phone/sdk/server/msg/file/FileSender$sendFile$2;
    move-object/from16 v6, p1

    .local v6, "$result":Ljava/lang/Object;
    iget-object v0, v5, Lcom/rokid/security/phone/sdk/server/msg/file/FileSender$sendFile$2;->L$0:Ljava/lang/Object;

    check-cast v0, Lkotlinx/coroutines/CoroutineScope;

    .restart local v0    # "$this$launch":Lkotlinx/coroutines/CoroutineScope;
    :try_start_4
    invoke-static {v6}, Lkotlin/ResultKt;->throwOnFailure(Ljava/lang/Object;)V
    :try_end_4
    .catch Ljava/lang/Exception; {:try_start_4 .. :try_end_4} :catch_2
    .catchall {:try_start_4 .. :try_end_4} :catchall_13

    move-object v7, v6

    goto :goto_1

    .end local v0    # "$this$launch":Lkotlinx/coroutines/CoroutineScope;
    .end local v5    # "this":Lcom/rokid/security/phone/sdk/server/msg/file/FileSender$sendFile$2;
    .end local v6    # "$result":Ljava/lang/Object;
    :pswitch_5
    move-object/from16 v5, p0

    .restart local v5    # "this":Lcom/rokid/security/phone/sdk/server/msg/file/FileSender$sendFile$2;
    move-object/from16 v6, p1

    .restart local v6    # "$result":Ljava/lang/Object;
    iget-object v0, v5, Lcom/rokid/security/phone/sdk/server/msg/file/FileSender$sendFile$2;->L$0:Ljava/lang/Object;

    check-cast v0, Lkotlinx/coroutines/CoroutineScope;

    .restart local v0    # "$this$launch":Lkotlinx/coroutines/CoroutineScope;
    :try_start_5
    invoke-static {v6}, Lkotlin/ResultKt;->throwOnFailure(Ljava/lang/Object;)V
    :try_end_5
    .catch Ljava/lang/Exception; {:try_start_5 .. :try_end_5} :catch_2
    .catchall {:try_start_5 .. :try_end_5} :catchall_13

    goto :goto_0

    .end local v0    # "$this$launch":Lkotlinx/coroutines/CoroutineScope;
    .end local v5    # "this":Lcom/rokid/security/phone/sdk/server/msg/file/FileSender$sendFile$2;
    .end local v6    # "$result":Ljava/lang/Object;
    :pswitch_6
    invoke-static/range {p1 .. p1}, Lkotlin/ResultKt;->throwOnFailure(Ljava/lang/Object;)V

    move-object/from16 v5, p0

    .restart local v5    # "this":Lcom/rokid/security/phone/sdk/server/msg/file/FileSender$sendFile$2;
    move-object/from16 v6, p1

    .restart local v6    # "$result":Ljava/lang/Object;
    iget-object v0, v5, Lcom/rokid/security/phone/sdk/server/msg/file/FileSender$sendFile$2;->L$0:Ljava/lang/Object;

    check-cast v0, Lkotlinx/coroutines/CoroutineScope;

    .line 60
    .restart local v0    # "$this$launch":Lkotlinx/coroutines/CoroutineScope;
    iget-object v7, v5, Lcom/rokid/security/phone/sdk/server/msg/file/FileSender$sendFile$2;->this$0:Lcom/rokid/security/phone/sdk/server/msg/file/FileSender;

    invoke-static {v7}, Lcom/rokid/security/phone/sdk/server/msg/file/FileSender;->access$getTAG$p(Lcom/rokid/security/phone/sdk/server/msg/file/FileSender;)Ljava/lang/String;

    move-result-object v7

    const-string/jumbo v8, "\u534f\u7a0b\u5df2\u542f\u52a8\uff0c\u5f00\u59cb\u6267\u884c P2P \u6587\u4ef6\u53d1\u9001\u903b\u8f91"

    filled-new-array {v8}, [Ljava/lang/Object;

    move-result-object v8

    invoke-static {v7, v8}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->i(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 61
    nop

    .line 62
    :try_start_6
    invoke-static {}, Lkotlinx/coroutines/Dispatchers;->getMain()Lkotlinx/coroutines/MainCoroutineDispatcher;

    move-result-object v7

    check-cast v7, Lkotlin/coroutines/CoroutineContext;

    new-instance v8, Lcom/rokid/security/phone/sdk/server/msg/file/FileSender$sendFile$2$1;

    iget-object v9, v5, Lcom/rokid/security/phone/sdk/server/msg/file/FileSender$sendFile$2;->this$0:Lcom/rokid/security/phone/sdk/server/msg/file/FileSender;

    iget-object v10, v5, Lcom/rokid/security/phone/sdk/server/msg/file/FileSender$sendFile$2;->$appListener:Lcom/rokid/security/phone/sdk/api/msg/listener/FileReceiveListener;

    const/4 v11, 0x0

    invoke-direct {v8, v9, v10, v11}, Lcom/rokid/security/phone/sdk/server/msg/file/FileSender$sendFile$2$1;-><init>(Lcom/rokid/security/phone/sdk/server/msg/file/FileSender;Lcom/rokid/security/phone/sdk/api/msg/listener/FileReceiveListener;Lkotlin/coroutines/Continuation;)V

    check-cast v8, Lkotlin/jvm/functions/Function2;

    move-object v9, v5

    check-cast v9, Lkotlin/coroutines/Continuation;

    iput-object v0, v5, Lcom/rokid/security/phone/sdk/server/msg/file/FileSender$sendFile$2;->L$0:Ljava/lang/Object;

    iput v4, v5, Lcom/rokid/security/phone/sdk/server/msg/file/FileSender$sendFile$2;->label:I

    invoke-static {v7, v8, v9}, Lkotlinx/coroutines/BuildersKt;->withContext(Lkotlin/coroutines/CoroutineContext;Lkotlin/jvm/functions/Function2;Lkotlin/coroutines/Continuation;)Ljava/lang/Object;

    move-result-object v7

    if-ne v7, v1, :cond_0

    .line 59
    return-object v1

    .line 67
    :cond_0
    :goto_0
    iget-object v7, v5, Lcom/rokid/security/phone/sdk/server/msg/file/FileSender$sendFile$2;->this$0:Lcom/rokid/security/phone/sdk/server/msg/file/FileSender;

    iget-object v8, v5, Lcom/rokid/security/phone/sdk/server/msg/file/FileSender$sendFile$2;->$host:Ljava/lang/String;

    iget-object v9, v5, Lcom/rokid/security/phone/sdk/server/msg/file/FileSender$sendFile$2;->$appListener:Lcom/rokid/security/phone/sdk/api/msg/listener/FileReceiveListener;

    iget-object v10, v5, Lcom/rokid/security/phone/sdk/server/msg/file/FileSender$sendFile$2;->$onResult:Lkotlin/jvm/functions/Function1;

    move-object v11, v5

    check-cast v11, Lkotlin/coroutines/Continuation;

    iput-object v0, v5, Lcom/rokid/security/phone/sdk/server/msg/file/FileSender$sendFile$2;->L$0:Ljava/lang/Object;

    iput v3, v5, Lcom/rokid/security/phone/sdk/server/msg/file/FileSender$sendFile$2;->label:I

    invoke-static {v7, v8, v9, v10, v11}, Lcom/rokid/security/phone/sdk/server/msg/file/FileSender;->access$connectSocket(Lcom/rokid/security/phone/sdk/server/msg/file/FileSender;Ljava/lang/String;Lcom/rokid/security/phone/sdk/api/msg/listener/FileReceiveListener;Lkotlin/jvm/functions/Function1;Lkotlin/coroutines/Continuation;)Ljava/lang/Object;

    move-result-object v7
    :try_end_6
    .catch Ljava/lang/Exception; {:try_start_6 .. :try_end_6} :catch_2
    .catchall {:try_start_6 .. :try_end_6} :catchall_13

    if-ne v7, v1, :cond_1

    .line 59
    return-object v1

    .line 67
    :cond_1
    :goto_1
    :try_start_7
    check-cast v7, Ljava/lang/Boolean;

    invoke-virtual {v7}, Ljava/lang/Boolean;->booleanValue()Z

    move-result v7
    :try_end_7
    .catch Ljava/lang/Exception; {:try_start_7 .. :try_end_7} :catch_1
    .catchall {:try_start_7 .. :try_end_7} :catchall_12

    .line 68
    .local v7, "ret":Z
    if-nez v7, :cond_2

    .line 69
    .end local v0    # "$this$launch":Lkotlinx/coroutines/CoroutineScope;
    :try_start_8
    sget-object v0, Lkotlin/Unit;->INSTANCE:Lkotlin/Unit;
    :try_end_8
    .catch Ljava/lang/Exception; {:try_start_8 .. :try_end_8} :catch_2
    .catchall {:try_start_8 .. :try_end_8} :catchall_13

    .line 130
    .end local v7    # "ret":Z
    iget-object v1, v5, Lcom/rokid/security/phone/sdk/server/msg/file/FileSender$sendFile$2;->this$0:Lcom/rokid/security/phone/sdk/server/msg/file/FileSender;

    invoke-virtual {v1}, Lcom/rokid/security/phone/sdk/server/msg/file/FileSender;->disconnectSocket()V

    .line 69
    return-object v0

    .line 72
    .restart local v0    # "$this$launch":Lkotlinx/coroutines/CoroutineScope;
    :cond_2
    :try_start_9
    new-instance v7, Ljava/io/FileInputStream;

    iget-object v8, v5, Lcom/rokid/security/phone/sdk/server/msg/file/FileSender$sendFile$2;->$file:Ljava/io/File;

    invoke-direct {v7, v8}, Ljava/io/FileInputStream;-><init>(Ljava/io/File;)V

    check-cast v7, Ljava/io/Closeable;

    iget-object v8, v5, Lcom/rokid/security/phone/sdk/server/msg/file/FileSender$sendFile$2;->$file:Ljava/io/File;

    iget-object v14, v5, Lcom/rokid/security/phone/sdk/server/msg/file/FileSender$sendFile$2;->this$0:Lcom/rokid/security/phone/sdk/server/msg/file/FileSender;

    iget-object v9, v5, Lcom/rokid/security/phone/sdk/server/msg/file/FileSender$sendFile$2;->$dir:Ljava/lang/String;

    iget-object v13, v5, Lcom/rokid/security/phone/sdk/server/msg/file/FileSender$sendFile$2;->$appListener:Lcom/rokid/security/phone/sdk/api/msg/listener/FileReceiveListener;

    iget-object v12, v5, Lcom/rokid/security/phone/sdk/server/msg/file/FileSender$sendFile$2;->$onResult:Lkotlin/jvm/functions/Function1;
    :try_end_9
    .catch Ljava/lang/Exception; {:try_start_9 .. :try_end_9} :catch_1
    .catchall {:try_start_9 .. :try_end_9} :catchall_12

    :try_start_a
    move-object v10, v7

    check-cast v10, Ljava/io/FileInputStream;

    move-object v11, v10

    .restart local v11    # "fileInputStream":Ljava/io/FileInputStream;
    const/4 v10, 0x0

    .line 73
    .local v10, "$i$a$-use-FileSender$sendFile$2$2":I
    invoke-virtual {v8}, Ljava/io/File;->length()J

    move-result-wide v16

    move-wide/from16 v23, v16

    .line 74
    .local v23, "fileLength":J
    const/16 v15, 0x1000

    new-array v15, v15, [B

    .line 75
    .local v15, "buffer":[B
    new-instance v16, Lkotlin/jvm/internal/Ref$IntRef;

    invoke-direct/range {v16 .. v16}, Lkotlin/jvm/internal/Ref$IntRef;-><init>()V

    move-object/from16 p1, v16

    .line 76
    .local p1, "bytesRead":Lkotlin/jvm/internal/Ref$IntRef;
    new-instance v16, Lkotlin/jvm/internal/Ref$LongRef;

    invoke-direct/range {v16 .. v16}, Lkotlin/jvm/internal/Ref$LongRef;-><init>()V

    move-object/from16 v25, v16

    .line 77
    .local v25, "totalBytesRead":Lkotlin/jvm/internal/Ref$LongRef;
    const/high16 v4, -0x40800000    # -1.0f

    .line 79
    .local v4, "lastProgress":F
    invoke-static {v14}, Lcom/rokid/security/phone/sdk/server/msg/file/FileSender;->access$getDataOutputStream$p(Lcom/rokid/security/phone/sdk/server/msg/file/FileSender;)Ljava/io/DataOutputStream;

    move-result-object v17
    :try_end_a
    .catchall {:try_start_a .. :try_end_a} :catchall_10

    if-eqz v17, :cond_4

    move-object/from16 v18, v17

    .local v18, "$this$invokeSuspend_u24lambda_u242_u24lambda_u240":Ljava/io/DataOutputStream;
    const/16 v17, 0x0

    .line 80
    .local v17, "$i$a$-apply-FileSender$sendFile$2$2$1":I
    if-nez v9, :cond_3

    :try_start_b
    invoke-virtual {v8}, Ljava/io/File;->getName()Ljava/lang/String;

    move-result-object v8
    :try_end_b
    .catchall {:try_start_b .. :try_end_b} :catchall_4

    goto :goto_2

    .line 72
    .end local v0    # "$this$launch":Lkotlinx/coroutines/CoroutineScope;
    .end local v4    # "lastProgress":F
    .end local v10    # "$i$a$-use-FileSender$sendFile$2$2":I
    .end local v11    # "fileInputStream":Ljava/io/FileInputStream;
    .end local v15    # "buffer":[B
    .end local v17    # "$i$a$-apply-FileSender$sendFile$2$2$1":I
    .end local v18    # "$this$invokeSuspend_u24lambda_u242_u24lambda_u240":Ljava/io/DataOutputStream;
    .end local v23    # "fileLength":J
    .end local v25    # "totalBytesRead":Lkotlin/jvm/internal/Ref$LongRef;
    .end local p1    # "bytesRead":Lkotlin/jvm/internal/Ref$IntRef;
    :catchall_4
    move-exception v0

    move-object v2, v0

    move-object v13, v1

    move-object v1, v5

    move-object v3, v6

    move-object v5, v7

    goto/16 :goto_c

    .line 80
    .restart local v0    # "$this$launch":Lkotlinx/coroutines/CoroutineScope;
    .restart local v4    # "lastProgress":F
    .restart local v10    # "$i$a$-use-FileSender$sendFile$2$2":I
    .restart local v11    # "fileInputStream":Ljava/io/FileInputStream;
    .restart local v15    # "buffer":[B
    .restart local v17    # "$i$a$-apply-FileSender$sendFile$2$2$1":I
    .restart local v18    # "$this$invokeSuspend_u24lambda_u242_u24lambda_u240":Ljava/io/DataOutputStream;
    .restart local v23    # "fileLength":J
    .restart local v25    # "totalBytesRead":Lkotlin/jvm/internal/Ref$LongRef;
    .restart local p1    # "bytesRead":Lkotlin/jvm/internal/Ref$IntRef;
    :cond_3
    :try_start_c
    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v3, v9}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v8}, Ljava/io/File;->getName()Ljava/lang/String;

    move-result-object v8

    invoke-virtual {v3, v8}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v8

    :goto_2
    move-object/from16 v3, v18

    .end local v18    # "$this$invokeSuspend_u24lambda_u242_u24lambda_u240":Ljava/io/DataOutputStream;
    .local v3, "$this$invokeSuspend_u24lambda_u242_u24lambda_u240":Ljava/io/DataOutputStream;
    invoke-virtual {v3, v8}, Ljava/io/DataOutputStream;->writeUTF(Ljava/lang/String;)V
    :try_end_c
    .catchall {:try_start_c .. :try_end_c} :catchall_6

    .line 81
    move-object v8, v1

    move-wide/from16 v1, v23

    .end local v23    # "fileLength":J
    .local v1, "fileLength":J
    :try_start_d
    invoke-virtual {v3, v1, v2}, Ljava/io/DataOutputStream;->writeLong(J)V

    .line 82
    invoke-virtual {v3}, Ljava/io/DataOutputStream;->flush()V
    :try_end_d
    .catchall {:try_start_d .. :try_end_d} :catchall_5

    .line 83
    nop

    .end local v3    # "$this$invokeSuspend_u24lambda_u242_u24lambda_u240":Ljava/io/DataOutputStream;
    .end local v17    # "$i$a$-apply-FileSender$sendFile$2$2$1":I
    goto :goto_4

    .line 72
    .end local v0    # "$this$launch":Lkotlinx/coroutines/CoroutineScope;
    .end local v1    # "fileLength":J
    .end local v4    # "lastProgress":F
    .end local v10    # "$i$a$-use-FileSender$sendFile$2$2":I
    .end local v11    # "fileInputStream":Ljava/io/FileInputStream;
    .end local v15    # "buffer":[B
    .end local v25    # "totalBytesRead":Lkotlin/jvm/internal/Ref$LongRef;
    .end local p1    # "bytesRead":Lkotlin/jvm/internal/Ref$IntRef;
    :catchall_5
    move-exception v0

    goto :goto_3

    :catchall_6
    move-exception v0

    move-object v8, v1

    :goto_3
    move-object v2, v0

    move-object v1, v5

    move-object v3, v6

    move-object v5, v7

    move-object v13, v8

    goto/16 :goto_c

    .line 79
    .restart local v0    # "$this$launch":Lkotlinx/coroutines/CoroutineScope;
    .restart local v4    # "lastProgress":F
    .restart local v10    # "$i$a$-use-FileSender$sendFile$2$2":I
    .restart local v11    # "fileInputStream":Ljava/io/FileInputStream;
    .restart local v15    # "buffer":[B
    .restart local v23    # "fileLength":J
    .restart local v25    # "totalBytesRead":Lkotlin/jvm/internal/Ref$LongRef;
    .restart local p1    # "bytesRead":Lkotlin/jvm/internal/Ref$IntRef;
    :cond_4
    move-object v8, v1

    move-wide/from16 v1, v23

    .end local v23    # "fileLength":J
    .restart local v1    # "fileLength":J
    :goto_4
    nop

    .line 85
    if-eqz v9, :cond_5

    :try_start_e
    const-string v3, "_ota_resume_v1/"
    :try_end_e
    .catchall {:try_start_e .. :try_end_e} :catchall_8

    move-object/from16 v23, v6

    move-object/from16 v26, v8

    move/from16 v24, v10

    const/4 v6, 0x2

    const/4 v8, 0x0

    const/4 v10, 0x0

    .end local v6    # "$result":Ljava/lang/Object;
    .end local v10    # "$i$a$-use-FileSender$sendFile$2$2":I
    .local v23, "$result":Ljava/lang/Object;
    .local v24, "$i$a$-use-FileSender$sendFile$2$2":I
    :try_start_f
    invoke-static {v9, v3, v10, v6, v8}, Lkotlin/text/StringsKt;->startsWith$default(Ljava/lang/String;Ljava/lang/String;ZILjava/lang/Object;)Z

    move-result v3

    const/4 v6, 0x1

    if-ne v3, v6, :cond_6

    goto :goto_5

    .line 72
    .end local v0    # "$this$launch":Lkotlinx/coroutines/CoroutineScope;
    .end local v1    # "fileLength":J
    .end local v4    # "lastProgress":F
    .end local v11    # "fileInputStream":Ljava/io/FileInputStream;
    .end local v15    # "buffer":[B
    .end local v24    # "$i$a$-use-FileSender$sendFile$2$2":I
    .end local v25    # "totalBytesRead":Lkotlin/jvm/internal/Ref$LongRef;
    .end local p1    # "bytesRead":Lkotlin/jvm/internal/Ref$IntRef;
    :catchall_7
    move-exception v0

    move-object v2, v0

    move-object v1, v5

    move-object v5, v7

    move-object/from16 v3, v23

    move-object/from16 v13, v26

    goto/16 :goto_c

    .end local v23    # "$result":Ljava/lang/Object;
    .restart local v6    # "$result":Ljava/lang/Object;
    :catchall_8
    move-exception v0

    move-object/from16 v23, v6

    move-object/from16 v26, v8

    move-object v2, v0

    move-object v1, v5

    move-object v5, v7

    move-object/from16 v3, v23

    move-object/from16 v13, v26

    goto/16 :goto_c

    .line 85
    .restart local v0    # "$this$launch":Lkotlinx/coroutines/CoroutineScope;
    .restart local v1    # "fileLength":J
    .restart local v4    # "lastProgress":F
    .restart local v10    # "$i$a$-use-FileSender$sendFile$2$2":I
    .restart local v11    # "fileInputStream":Ljava/io/FileInputStream;
    .restart local v15    # "buffer":[B
    .restart local v25    # "totalBytesRead":Lkotlin/jvm/internal/Ref$LongRef;
    .restart local p1    # "bytesRead":Lkotlin/jvm/internal/Ref$IntRef;
    :cond_5
    move-object/from16 v23, v6

    move-object/from16 v26, v8

    move/from16 v24, v10

    .end local v6    # "$result":Ljava/lang/Object;
    .end local v10    # "$i$a$-use-FileSender$sendFile$2$2":I
    .restart local v23    # "$result":Ljava/lang/Object;
    .restart local v24    # "$i$a$-use-FileSender$sendFile$2$2":I
    :cond_6
    const/4 v6, 0x0

    :goto_5
    const-wide/16 v8, 0x0

    if-eqz v6, :cond_7

    .line 86
    invoke-static {v14, v1, v2}, Lcom/rokid/security/phone/sdk/server/msg/file/FileSender;->access$readResumeOffset(Lcom/rokid/security/phone/sdk/server/msg/file/FileSender;J)J

    move-result-wide v16
    :try_end_f
    .catchall {:try_start_f .. :try_end_f} :catchall_7

    goto :goto_6

    .line 88
    :cond_7
    move-wide/from16 v16, v8

    .line 85
    :goto_6
    move-wide/from16 v27, v16

    .line 90
    .local v27, "resumeOffset":J
    move v6, v4

    move-wide/from16 v3, v27

    .end local v4    # "lastProgress":F
    .end local v27    # "resumeOffset":J
    .local v3, "resumeOffset":J
    .local v6, "lastProgress":F
    cmp-long v8, v3, v8

    if-lez v8, :cond_9

    .line 91
    :try_start_10
    invoke-virtual {v11}, Ljava/io/FileInputStream;->getChannel()Ljava/nio/channels/FileChannel;

    move-result-object v8

    invoke-virtual {v8, v3, v4}, Ljava/nio/channels/FileChannel;->position(J)Ljava/nio/channels/FileChannel;

    .line 92
    move-object/from16 v8, v25

    .end local v25    # "totalBytesRead":Lkotlin/jvm/internal/Ref$LongRef;
    .restart local v8    # "totalBytesRead":Lkotlin/jvm/internal/Ref$LongRef;
    iput-wide v3, v8, Lkotlin/jvm/internal/Ref$LongRef;->element:J

    .line 93
    invoke-static {v14}, Lcom/rokid/security/phone/sdk/server/msg/file/FileSender;->access$getTAG$p(Lcom/rokid/security/phone/sdk/server/msg/file/FileSender;)Ljava/lang/String;

    move-result-object v9

    new-instance v10, Ljava/lang/StringBuilder;

    invoke-direct {v10}, Ljava/lang/StringBuilder;-><init>()V

    move/from16 v25, v6

    .end local v6    # "lastProgress":F
    .local v25, "lastProgress":F
    const-string v6, "flow=ota src=phone stage=transfer event=resume bytes="

    invoke-virtual {v10, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6, v3, v4}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v6

    const-string v10, " total="

    invoke-virtual {v6, v10}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6, v1, v2}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v6

    filled-new-array {v6}, [Ljava/lang/Object;

    move-result-object v6

    invoke-static {v9, v6}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->i(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 94
    invoke-static {}, Lkotlinx/coroutines/Dispatchers;->getMain()Lkotlinx/coroutines/MainCoroutineDispatcher;

    move-result-object v6

    check-cast v6, Lkotlin/coroutines/CoroutineContext;

    new-instance v9, Lcom/rokid/security/phone/sdk/server/msg/file/FileSender$sendFile$2$2$2;

    const/16 v22, 0x0

    move-object/from16 v16, v9

    move-object/from16 v17, v13

    move-wide/from16 v18, v3

    move-wide/from16 v20, v1

    invoke-direct/range {v16 .. v22}, Lcom/rokid/security/phone/sdk/server/msg/file/FileSender$sendFile$2$2$2;-><init>(Lcom/rokid/security/phone/sdk/api/msg/listener/FileReceiveListener;JJLkotlin/coroutines/Continuation;)V

    check-cast v9, Lkotlin/jvm/functions/Function2;

    iput-object v0, v5, Lcom/rokid/security/phone/sdk/server/msg/file/FileSender$sendFile$2;->L$0:Ljava/lang/Object;

    iput-object v7, v5, Lcom/rokid/security/phone/sdk/server/msg/file/FileSender$sendFile$2;->L$1:Ljava/lang/Object;

    iput-object v14, v5, Lcom/rokid/security/phone/sdk/server/msg/file/FileSender$sendFile$2;->L$2:Ljava/lang/Object;

    iput-object v13, v5, Lcom/rokid/security/phone/sdk/server/msg/file/FileSender$sendFile$2;->L$3:Ljava/lang/Object;

    iput-object v12, v5, Lcom/rokid/security/phone/sdk/server/msg/file/FileSender$sendFile$2;->L$4:Ljava/lang/Object;

    iput-object v11, v5, Lcom/rokid/security/phone/sdk/server/msg/file/FileSender$sendFile$2;->L$5:Ljava/lang/Object;

    iput-object v15, v5, Lcom/rokid/security/phone/sdk/server/msg/file/FileSender$sendFile$2;->L$6:Ljava/lang/Object;

    move-object/from16 v10, p1

    .end local p1    # "bytesRead":Lkotlin/jvm/internal/Ref$IntRef;
    .local v10, "bytesRead":Lkotlin/jvm/internal/Ref$IntRef;
    iput-object v10, v5, Lcom/rokid/security/phone/sdk/server/msg/file/FileSender$sendFile$2;->L$7:Ljava/lang/Object;

    iput-object v8, v5, Lcom/rokid/security/phone/sdk/server/msg/file/FileSender$sendFile$2;->L$8:Ljava/lang/Object;

    iput-wide v1, v5, Lcom/rokid/security/phone/sdk/server/msg/file/FileSender$sendFile$2;->J$0:J

    move-object/from16 v16, v0

    move/from16 v0, v25

    .end local v25    # "lastProgress":F
    .local v0, "lastProgress":F
    .local v16, "$this$launch":Lkotlinx/coroutines/CoroutineScope;
    iput v0, v5, Lcom/rokid/security/phone/sdk/server/msg/file/FileSender$sendFile$2;->F$0:F

    move/from16 v25, v0

    .end local v0    # "lastProgress":F
    .restart local v25    # "lastProgress":F
    const/4 v0, 0x3

    iput v0, v5, Lcom/rokid/security/phone/sdk/server/msg/file/FileSender$sendFile$2;->label:I

    invoke-static {v6, v9, v5}, Lkotlinx/coroutines/BuildersKt;->withContext(Lkotlin/coroutines/CoroutineContext;Lkotlin/jvm/functions/Function2;Lkotlin/coroutines/Continuation;)Ljava/lang/Object;

    move-result-object v0
    :try_end_10
    .catchall {:try_start_10 .. :try_end_10} :catchall_9

    move-object/from16 v9, v26

    .end local v3    # "resumeOffset":J
    if-ne v0, v9, :cond_8

    .line 59
    return-object v9

    .line 94
    :cond_8
    move-object v3, v5

    move-object/from16 v0, v16

    move-object/from16 v4, v23

    move/from16 v5, v25

    move-wide/from16 v33, v1

    move-object v1, v7

    move-wide/from16 v6, v33

    .line 103
    .end local v1    # "fileLength":J
    .end local v16    # "$this$launch":Lkotlinx/coroutines/CoroutineScope;
    .end local v23    # "$result":Ljava/lang/Object;
    .end local v25    # "lastProgress":F
    .local v0, "$this$launch":Lkotlinx/coroutines/CoroutineScope;
    .local v3, "this":Lcom/rokid/security/phone/sdk/server/msg/file/FileSender$sendFile$2;
    .local v4, "$result":Ljava/lang/Object;
    .local v5, "lastProgress":F
    .local v6, "fileLength":J
    :goto_7
    move-object v2, v1

    move-object/from16 v23, v4

    move v4, v5

    move-object v1, v9

    move-object v9, v10

    move-object v10, v12

    const/16 v16, 0x0

    move-object/from16 v33, v11

    move-object v11, v8

    move-object v8, v15

    move-object v15, v13

    move-wide v12, v6

    move-object/from16 v7, v33

    goto :goto_8

    .line 72
    .end local v0    # "$this$launch":Lkotlinx/coroutines/CoroutineScope;
    .end local v3    # "this":Lcom/rokid/security/phone/sdk/server/msg/file/FileSender$sendFile$2;
    .end local v4    # "$result":Ljava/lang/Object;
    .end local v6    # "fileLength":J
    .end local v8    # "totalBytesRead":Lkotlin/jvm/internal/Ref$LongRef;
    .end local v10    # "bytesRead":Lkotlin/jvm/internal/Ref$IntRef;
    .end local v11    # "fileInputStream":Ljava/io/FileInputStream;
    .end local v15    # "buffer":[B
    .end local v24    # "$i$a$-use-FileSender$sendFile$2$2":I
    .local v5, "this":Lcom/rokid/security/phone/sdk/server/msg/file/FileSender$sendFile$2;
    .restart local v23    # "$result":Ljava/lang/Object;
    :catchall_9
    move-exception v0

    move-object/from16 v9, v26

    move-object v2, v0

    move-object v1, v5

    move-object v5, v7

    move-object v13, v9

    move-object/from16 v3, v23

    goto/16 :goto_c

    .line 90
    .restart local v0    # "$this$launch":Lkotlinx/coroutines/CoroutineScope;
    .restart local v1    # "fileLength":J
    .local v3, "resumeOffset":J
    .local v6, "lastProgress":F
    .restart local v11    # "fileInputStream":Ljava/io/FileInputStream;
    .restart local v15    # "buffer":[B
    .restart local v24    # "$i$a$-use-FileSender$sendFile$2$2":I
    .local v25, "totalBytesRead":Lkotlin/jvm/internal/Ref$LongRef;
    .restart local p1    # "bytesRead":Lkotlin/jvm/internal/Ref$IntRef;
    :cond_9
    move-object/from16 v10, p1

    move-object/from16 v16, v0

    move-object/from16 v8, v25

    move-object/from16 v9, v26

    move/from16 v25, v6

    .end local v0    # "$this$launch":Lkotlinx/coroutines/CoroutineScope;
    .end local v6    # "lastProgress":F
    .end local p1    # "bytesRead":Lkotlin/jvm/internal/Ref$IntRef;
    .restart local v8    # "totalBytesRead":Lkotlin/jvm/internal/Ref$LongRef;
    .restart local v10    # "bytesRead":Lkotlin/jvm/internal/Ref$IntRef;
    .restart local v16    # "$this$launch":Lkotlinx/coroutines/CoroutineScope;
    .local v25, "lastProgress":F
    move-object v3, v5

    move/from16 v4, v25

    const/16 v16, 0x0

    move-wide/from16 v33, v1

    move-object v2, v7

    move-object v1, v9

    move-object v9, v10

    move-object v7, v11

    move-object v10, v12

    move-object v11, v8

    move-object v8, v15

    move-object v15, v13

    move-wide/from16 v12, v33

    .line 103
    .end local v1    # "fileLength":J
    .end local v5    # "this":Lcom/rokid/security/phone/sdk/server/msg/file/FileSender$sendFile$2;
    .end local v10    # "bytesRead":Lkotlin/jvm/internal/Ref$IntRef;
    .end local v15    # "buffer":[B
    .end local v16    # "$this$launch":Lkotlinx/coroutines/CoroutineScope;
    .end local v25    # "lastProgress":F
    .restart local v0    # "$this$launch":Lkotlinx/coroutines/CoroutineScope;
    .local v3, "this":Lcom/rokid/security/phone/sdk/server/msg/file/FileSender$sendFile$2;
    .local v4, "lastProgress":F
    .local v7, "fileInputStream":Ljava/io/FileInputStream;
    .local v8, "buffer":[B
    .restart local v9    # "bytesRead":Lkotlin/jvm/internal/Ref$IntRef;
    .local v11, "totalBytesRead":Lkotlin/jvm/internal/Ref$LongRef;
    .local v12, "fileLength":J
    :goto_8
    :try_start_11
    invoke-virtual {v7, v8}, Ljava/io/FileInputStream;->read([B)I

    move-result v5

    move v6, v5

    .line 205
    .local v6, "it":I
    const/16 v17, 0x0

    .line 103
    .local v17, "$i$a$-also-FileSender$sendFile$2$2$3":I
    iput v6, v9, Lkotlin/jvm/internal/Ref$IntRef;->element:I

    .end local v6    # "it":I
    .end local v17    # "$i$a$-also-FileSender$sendFile$2$2$3":I
    const/4 v6, -0x1

    if-eq v5, v6, :cond_d

    invoke-static {v0}, Lkotlinx/coroutines/CoroutineScopeKt;->isActive(Lkotlinx/coroutines/CoroutineScope;)Z

    move-result v5

    if-eqz v5, :cond_d

    .line 104
    invoke-static {v14}, Lcom/rokid/security/phone/sdk/server/msg/file/FileSender;->access$getOutputStream$p(Lcom/rokid/security/phone/sdk/server/msg/file/FileSender;)Ljava/io/OutputStream;

    move-result-object v5
    :try_end_11
    .catchall {:try_start_11 .. :try_end_11} :catchall_f

    if-eqz v5, :cond_a

    :try_start_12
    iget v6, v9, Lkotlin/jvm/internal/Ref$IntRef;->element:I
    :try_end_12
    .catchall {:try_start_12 .. :try_end_12} :catchall_b

    move-object/from16 v17, v1

    const/4 v1, 0x0

    :try_start_13
    invoke-virtual {v5, v8, v1, v6}, Ljava/io/OutputStream;->write([BII)V
    :try_end_13
    .catchall {:try_start_13 .. :try_end_13} :catchall_a

    goto :goto_9

    .line 72
    .end local v0    # "$this$launch":Lkotlinx/coroutines/CoroutineScope;
    .end local v4    # "lastProgress":F
    .end local v7    # "fileInputStream":Ljava/io/FileInputStream;
    .end local v8    # "buffer":[B
    .end local v9    # "bytesRead":Lkotlin/jvm/internal/Ref$IntRef;
    .end local v11    # "totalBytesRead":Lkotlin/jvm/internal/Ref$LongRef;
    .end local v12    # "fileLength":J
    .end local v24    # "$i$a$-use-FileSender$sendFile$2$2":I
    :catchall_a
    move-exception v0

    move-object v5, v2

    move-object v1, v3

    move-object/from16 v13, v17

    move-object/from16 v3, v23

    move-object v2, v0

    goto/16 :goto_c

    :catchall_b
    move-exception v0

    move-object/from16 v17, v1

    move-object v5, v2

    move-object v1, v3

    move-object/from16 v13, v17

    move-object/from16 v3, v23

    move-object v2, v0

    goto/16 :goto_c

    .line 104
    .restart local v0    # "$this$launch":Lkotlinx/coroutines/CoroutineScope;
    .restart local v4    # "lastProgress":F
    .restart local v7    # "fileInputStream":Ljava/io/FileInputStream;
    .restart local v8    # "buffer":[B
    .restart local v9    # "bytesRead":Lkotlin/jvm/internal/Ref$IntRef;
    .restart local v11    # "totalBytesRead":Lkotlin/jvm/internal/Ref$LongRef;
    .restart local v12    # "fileLength":J
    .restart local v24    # "$i$a$-use-FileSender$sendFile$2$2":I
    :cond_a
    move-object/from16 v17, v1

    const/4 v1, 0x0

    .line 105
    :goto_9
    :try_start_14
    iget-wide v5, v11, Lkotlin/jvm/internal/Ref$LongRef;->element:J

    iget v1, v9, Lkotlin/jvm/internal/Ref$IntRef;->element:I

    move-object/from16 v19, v7

    move-object/from16 v18, v8

    .end local v7    # "fileInputStream":Ljava/io/FileInputStream;
    .end local v8    # "buffer":[B
    .local v18, "buffer":[B
    .local v19, "fileInputStream":Ljava/io/FileInputStream;
    int-to-long v7, v1

    add-long/2addr v5, v7

    iput-wide v5, v11, Lkotlin/jvm/internal/Ref$LongRef;->element:J

    .line 107
    iget-wide v5, v11, Lkotlin/jvm/internal/Ref$LongRef;->element:J

    long-to-float v1, v5

    long-to-float v5, v12

    div-float/2addr v1, v5

    const/16 v5, 0x64

    int-to-float v5, v5

    mul-float/2addr v1, v5

    .line 108
    .local v1, "currentProgress":F
    sub-float v5, v1, v4

    invoke-static {v5}, Ljava/lang/Math;->abs(F)F

    move-result v5

    invoke-static {v14}, Lcom/rokid/security/phone/sdk/server/msg/file/FileSender;->access$getProgressUpdateThreshold$p(Lcom/rokid/security/phone/sdk/server/msg/file/FileSender;)F

    move-result v6

    cmpl-float v5, v5, v6

    if-ltz v5, :cond_c

    .line 109
    .end local v4    # "lastProgress":F
    invoke-static {}, Lkotlinx/coroutines/Dispatchers;->getMain()Lkotlinx/coroutines/MainCoroutineDispatcher;

    move-result-object v4

    check-cast v4, Lkotlin/coroutines/CoroutineContext;

    new-instance v20, Lcom/rokid/security/phone/sdk/server/msg/file/FileSender$sendFile$2$2$4;

    const/16 v21, 0x0

    move-object/from16 v5, v20

    move-object v6, v14

    move-object/from16 v8, v19

    .end local v19    # "fileInputStream":Ljava/io/FileInputStream;
    .local v8, "fileInputStream":Ljava/io/FileInputStream;
    move v7, v1

    move-object/from16 p1, v4

    move-object/from16 v4, v18

    move/from16 v18, v1

    move-object v1, v8

    .end local v8    # "fileInputStream":Ljava/io/FileInputStream;
    .local v1, "fileInputStream":Ljava/io/FileInputStream;
    .local v4, "buffer":[B
    .local v18, "currentProgress":F
    move-object v8, v15

    move-object/from16 v29, v9

    .end local v9    # "bytesRead":Lkotlin/jvm/internal/Ref$IntRef;
    .local v29, "bytesRead":Lkotlin/jvm/internal/Ref$IntRef;
    move-object v9, v11

    move-object/from16 v19, v4

    move-object v4, v10

    move-object/from16 v30, v11

    .end local v4    # "buffer":[B
    .end local v11    # "totalBytesRead":Lkotlin/jvm/internal/Ref$LongRef;
    .local v19, "buffer":[B
    .local v30, "totalBytesRead":Lkotlin/jvm/internal/Ref$LongRef;
    move-wide v10, v12

    move-wide/from16 v31, v12

    .end local v12    # "fileLength":J
    .local v31, "fileLength":J
    move-object/from16 v12, v21

    invoke-direct/range {v5 .. v12}, Lcom/rokid/security/phone/sdk/server/msg/file/FileSender$sendFile$2$2$4;-><init>(Lcom/rokid/security/phone/sdk/server/msg/file/FileSender;FLcom/rokid/security/phone/sdk/api/msg/listener/FileReceiveListener;Lkotlin/jvm/internal/Ref$LongRef;JLkotlin/coroutines/Continuation;)V

    move-object/from16 v5, v20

    check-cast v5, Lkotlin/jvm/functions/Function2;

    iput-object v0, v3, Lcom/rokid/security/phone/sdk/server/msg/file/FileSender$sendFile$2;->L$0:Ljava/lang/Object;

    iput-object v2, v3, Lcom/rokid/security/phone/sdk/server/msg/file/FileSender$sendFile$2;->L$1:Ljava/lang/Object;

    iput-object v14, v3, Lcom/rokid/security/phone/sdk/server/msg/file/FileSender$sendFile$2;->L$2:Ljava/lang/Object;

    iput-object v15, v3, Lcom/rokid/security/phone/sdk/server/msg/file/FileSender$sendFile$2;->L$3:Ljava/lang/Object;

    iput-object v4, v3, Lcom/rokid/security/phone/sdk/server/msg/file/FileSender$sendFile$2;->L$4:Ljava/lang/Object;

    iput-object v1, v3, Lcom/rokid/security/phone/sdk/server/msg/file/FileSender$sendFile$2;->L$5:Ljava/lang/Object;

    move-object/from16 v6, v19

    .end local v19    # "buffer":[B
    .local v6, "buffer":[B
    iput-object v6, v3, Lcom/rokid/security/phone/sdk/server/msg/file/FileSender$sendFile$2;->L$6:Ljava/lang/Object;

    move-object/from16 v10, v29

    .end local v29    # "bytesRead":Lkotlin/jvm/internal/Ref$IntRef;
    .restart local v10    # "bytesRead":Lkotlin/jvm/internal/Ref$IntRef;
    iput-object v10, v3, Lcom/rokid/security/phone/sdk/server/msg/file/FileSender$sendFile$2;->L$7:Ljava/lang/Object;

    move-object/from16 v8, v30

    .end local v30    # "totalBytesRead":Lkotlin/jvm/internal/Ref$LongRef;
    .local v8, "totalBytesRead":Lkotlin/jvm/internal/Ref$LongRef;
    iput-object v8, v3, Lcom/rokid/security/phone/sdk/server/msg/file/FileSender$sendFile$2;->L$8:Ljava/lang/Object;

    move-wide/from16 v11, v31

    .end local v31    # "fileLength":J
    .local v11, "fileLength":J
    iput-wide v11, v3, Lcom/rokid/security/phone/sdk/server/msg/file/FileSender$sendFile$2;->J$0:J

    move/from16 v7, v18

    .end local v18    # "currentProgress":F
    .local v7, "currentProgress":F
    iput v7, v3, Lcom/rokid/security/phone/sdk/server/msg/file/FileSender$sendFile$2;->F$0:F

    const/4 v9, 0x4

    iput v9, v3, Lcom/rokid/security/phone/sdk/server/msg/file/FileSender$sendFile$2;->label:I

    move-object/from16 v9, p1

    invoke-static {v9, v5, v3}, Lkotlinx/coroutines/BuildersKt;->withContext(Lkotlin/coroutines/CoroutineContext;Lkotlin/jvm/functions/Function2;Lkotlin/coroutines/Continuation;)Ljava/lang/Object;

    move-result-object v5
    :try_end_14
    .catchall {:try_start_14 .. :try_end_14} :catchall_c

    move-object/from16 v13, v17

    if-ne v5, v13, :cond_b

    .line 59
    return-object v13

    .line 109
    :cond_b
    move-object v9, v10

    move-object v10, v4

    move-wide v4, v11

    move-object v11, v8

    move-object v8, v6

    move-object/from16 v33, v13

    move-object v13, v1

    move-object/from16 v1, v33

    .line 113
    .end local v1    # "fileInputStream":Ljava/io/FileInputStream;
    .end local v6    # "buffer":[B
    .end local v10    # "bytesRead":Lkotlin/jvm/internal/Ref$IntRef;
    .local v4, "fileLength":J
    .local v8, "buffer":[B
    .restart local v9    # "bytesRead":Lkotlin/jvm/internal/Ref$IntRef;
    .local v11, "totalBytesRead":Lkotlin/jvm/internal/Ref$LongRef;
    .restart local v13    # "fileInputStream":Ljava/io/FileInputStream;
    :goto_a
    move v6, v7

    move-object v7, v13

    move-wide v12, v4

    move v4, v6

    .end local v7    # "currentProgress":F
    .local v6, "lastProgress":F
    goto/16 :goto_8

    .line 108
    .end local v6    # "lastProgress":F
    .end local v8    # "buffer":[B
    .end local v13    # "fileInputStream":Ljava/io/FileInputStream;
    .local v1, "currentProgress":F
    .local v4, "lastProgress":F
    .restart local v12    # "fileLength":J
    .local v18, "buffer":[B
    .local v19, "fileInputStream":Ljava/io/FileInputStream;
    :cond_c
    move v7, v1

    move v5, v4

    move-object v4, v10

    move-object v8, v11

    move-wide v11, v12

    move-object/from16 v13, v17

    move-object/from16 v6, v18

    move-object/from16 v1, v19

    move-object v10, v9

    .end local v4    # "lastProgress":F
    .end local v9    # "bytesRead":Lkotlin/jvm/internal/Ref$IntRef;
    .end local v12    # "fileLength":J
    .end local v18    # "buffer":[B
    .end local v19    # "fileInputStream":Ljava/io/FileInputStream;
    .local v1, "fileInputStream":Ljava/io/FileInputStream;
    .local v5, "lastProgress":F
    .local v6, "buffer":[B
    .restart local v7    # "currentProgress":F
    .local v8, "totalBytesRead":Lkotlin/jvm/internal/Ref$LongRef;
    .restart local v10    # "bytesRead":Lkotlin/jvm/internal/Ref$IntRef;
    .local v11, "fileLength":J
    move-object v7, v1

    move-object v1, v13

    move-object v10, v4

    move v4, v5

    move-wide v12, v11

    move-object v11, v8

    move-object v8, v6

    goto/16 :goto_8

    .line 72
    .end local v0    # "$this$launch":Lkotlinx/coroutines/CoroutineScope;
    .end local v1    # "fileInputStream":Ljava/io/FileInputStream;
    .end local v5    # "lastProgress":F
    .end local v6    # "buffer":[B
    .end local v7    # "currentProgress":F
    .end local v8    # "totalBytesRead":Lkotlin/jvm/internal/Ref$LongRef;
    .end local v10    # "bytesRead":Lkotlin/jvm/internal/Ref$IntRef;
    .end local v11    # "fileLength":J
    .end local v24    # "$i$a$-use-FileSender$sendFile$2$2":I
    :catchall_c
    move-exception v0

    move-object/from16 v13, v17

    move-object v5, v2

    move-object v1, v3

    move-object/from16 v3, v23

    move-object v2, v0

    goto/16 :goto_c

    .line 103
    .restart local v0    # "$this$launch":Lkotlinx/coroutines/CoroutineScope;
    .restart local v4    # "lastProgress":F
    .local v7, "fileInputStream":Ljava/io/FileInputStream;
    .local v8, "buffer":[B
    .restart local v9    # "bytesRead":Lkotlin/jvm/internal/Ref$IntRef;
    .local v11, "totalBytesRead":Lkotlin/jvm/internal/Ref$LongRef;
    .restart local v12    # "fileLength":J
    .restart local v24    # "$i$a$-use-FileSender$sendFile$2$2":I
    :cond_d
    move v5, v4

    move-object v6, v8

    move-object v4, v10

    move-object v8, v11

    move-wide v11, v12

    move-object v13, v1

    move-object v1, v7

    move-object v10, v9

    .line 117
    .end local v0    # "$this$launch":Lkotlinx/coroutines/CoroutineScope;
    .end local v4    # "lastProgress":F
    .end local v7    # "fileInputStream":Ljava/io/FileInputStream;
    .end local v8    # "buffer":[B
    .end local v9    # "bytesRead":Lkotlin/jvm/internal/Ref$IntRef;
    .end local v12    # "fileLength":J
    .local v11, "fileLength":J
    :try_start_15
    invoke-static {v14}, Lcom/rokid/security/phone/sdk/server/msg/file/FileSender;->access$getOutputStream$p(Lcom/rokid/security/phone/sdk/server/msg/file/FileSender;)Ljava/io/OutputStream;

    move-result-object v0

    if-eqz v0, :cond_e

    invoke-virtual {v0}, Ljava/io/OutputStream;->flush()V

    .line 118
    :cond_e
    invoke-static {}, Lkotlinx/coroutines/Dispatchers;->getMain()Lkotlinx/coroutines/MainCoroutineDispatcher;

    move-result-object v0

    check-cast v0, Lkotlin/coroutines/CoroutineContext;

    new-instance v1, Lcom/rokid/security/phone/sdk/server/msg/file/FileSender$sendFile$2$2$5;

    const/4 v10, 0x0

    move-object v5, v1

    move-object v6, v15

    move-wide v7, v11

    move-object v9, v4

    invoke-direct/range {v5 .. v10}, Lcom/rokid/security/phone/sdk/server/msg/file/FileSender$sendFile$2$2$5;-><init>(Lcom/rokid/security/phone/sdk/api/msg/listener/FileReceiveListener;JLkotlin/jvm/functions/Function1;Lkotlin/coroutines/Continuation;)V

    check-cast v1, Lkotlin/jvm/functions/Function2;

    iput-object v2, v3, Lcom/rokid/security/phone/sdk/server/msg/file/FileSender$sendFile$2;->L$0:Ljava/lang/Object;

    const/4 v4, 0x0

    iput-object v4, v3, Lcom/rokid/security/phone/sdk/server/msg/file/FileSender$sendFile$2;->L$1:Ljava/lang/Object;

    iput-object v4, v3, Lcom/rokid/security/phone/sdk/server/msg/file/FileSender$sendFile$2;->L$2:Ljava/lang/Object;

    iput-object v4, v3, Lcom/rokid/security/phone/sdk/server/msg/file/FileSender$sendFile$2;->L$3:Ljava/lang/Object;

    iput-object v4, v3, Lcom/rokid/security/phone/sdk/server/msg/file/FileSender$sendFile$2;->L$4:Ljava/lang/Object;

    iput-object v4, v3, Lcom/rokid/security/phone/sdk/server/msg/file/FileSender$sendFile$2;->L$5:Ljava/lang/Object;

    iput-object v4, v3, Lcom/rokid/security/phone/sdk/server/msg/file/FileSender$sendFile$2;->L$6:Ljava/lang/Object;

    iput-object v4, v3, Lcom/rokid/security/phone/sdk/server/msg/file/FileSender$sendFile$2;->L$7:Ljava/lang/Object;

    iput-object v4, v3, Lcom/rokid/security/phone/sdk/server/msg/file/FileSender$sendFile$2;->L$8:Ljava/lang/Object;

    const/4 v4, 0x5

    iput v4, v3, Lcom/rokid/security/phone/sdk/server/msg/file/FileSender$sendFile$2;->label:I

    invoke-static {v0, v1, v3}, Lkotlinx/coroutines/BuildersKt;->withContext(Lkotlin/coroutines/CoroutineContext;Lkotlin/jvm/functions/Function2;Lkotlin/coroutines/Continuation;)Ljava/lang/Object;

    move-result-object v0
    :try_end_15
    .catchall {:try_start_15 .. :try_end_15} :catchall_e

    .end local v11    # "fileLength":J
    if-ne v0, v13, :cond_f

    .line 59
    return-object v13

    .line 118
    :cond_f
    move-object v5, v2

    move-object v1, v3

    move-object/from16 v11, v16

    move-object/from16 v3, v23

    move/from16 v0, v24

    .line 122
    .end local v23    # "$result":Ljava/lang/Object;
    .end local v24    # "$i$a$-use-FileSender$sendFile$2$2":I
    .local v0, "$i$a$-use-FileSender$sendFile$2$2":I
    .local v1, "this":Lcom/rokid/security/phone/sdk/server/msg/file/FileSender$sendFile$2;
    .local v3, "$result":Ljava/lang/Object;
    :goto_b
    :try_start_16
    sget-object v0, Lkotlin/Unit;->INSTANCE:Lkotlin/Unit;
    :try_end_16
    .catchall {:try_start_16 .. :try_end_16} :catchall_d

    .line 72
    .end local v0    # "$i$a$-use-FileSender$sendFile$2$2":I
    :try_start_17
    invoke-static {v5, v11}, Lkotlin/io/CloseableKt;->closeFinally(Ljava/io/Closeable;Ljava/lang/Throwable;)V
    :try_end_17
    .catch Ljava/lang/Exception; {:try_start_17 .. :try_end_17} :catch_0
    .catchall {:try_start_17 .. :try_end_17} :catchall_0

    goto/16 :goto_e

    .line 123
    :catch_0
    move-exception v0

    move-object v9, v13

    goto :goto_d

    .line 72
    :catchall_d
    move-exception v0

    move-object v2, v0

    goto :goto_c

    .end local v1    # "this":Lcom/rokid/security/phone/sdk/server/msg/file/FileSender$sendFile$2;
    .local v3, "this":Lcom/rokid/security/phone/sdk/server/msg/file/FileSender$sendFile$2;
    .restart local v23    # "$result":Ljava/lang/Object;
    :catchall_e
    move-exception v0

    move-object v5, v2

    move-object v1, v3

    move-object/from16 v3, v23

    move-object v2, v0

    goto :goto_c

    :catchall_f
    move-exception v0

    move-object v13, v1

    move-object v5, v2

    move-object v1, v3

    move-object/from16 v3, v23

    move-object v2, v0

    goto :goto_c

    .end local v3    # "this":Lcom/rokid/security/phone/sdk/server/msg/file/FileSender$sendFile$2;
    .end local v23    # "$result":Ljava/lang/Object;
    .local v5, "this":Lcom/rokid/security/phone/sdk/server/msg/file/FileSender$sendFile$2;
    .local v6, "$result":Ljava/lang/Object;
    :catchall_10
    move-exception v0

    move-object v9, v1

    move-object/from16 v23, v6

    move-object v2, v0

    move-object v1, v5

    move-object v5, v7

    move-object v13, v9

    move-object/from16 v3, v23

    .end local v5    # "this":Lcom/rokid/security/phone/sdk/server/msg/file/FileSender$sendFile$2;
    .end local v6    # "$result":Ljava/lang/Object;
    :goto_c
    :try_start_18
    throw v2
    :try_end_18
    .catchall {:try_start_18 .. :try_end_18} :catchall_11

    .restart local v1    # "this":Lcom/rokid/security/phone/sdk/server/msg/file/FileSender$sendFile$2;
    .local v3, "$result":Ljava/lang/Object;
    :catchall_11
    move-exception v0

    move-object v4, v0

    :try_start_19
    invoke-static {v5, v2}, Lkotlin/io/CloseableKt;->closeFinally(Ljava/io/Closeable;Ljava/lang/Throwable;)V

    .end local v1    # "this":Lcom/rokid/security/phone/sdk/server/msg/file/FileSender$sendFile$2;
    .end local v3    # "$result":Ljava/lang/Object;
    throw v4
    :try_end_19
    .catch Ljava/lang/Exception; {:try_start_19 .. :try_end_19} :catch_0
    .catchall {:try_start_19 .. :try_end_19} :catchall_0

    .line 130
    .restart local v5    # "this":Lcom/rokid/security/phone/sdk/server/msg/file/FileSender$sendFile$2;
    .restart local v6    # "$result":Ljava/lang/Object;
    :catchall_12
    move-exception v0

    move-object/from16 v23, v6

    move-object v1, v5

    move-object/from16 v3, v23

    .end local v6    # "$result":Ljava/lang/Object;
    .restart local v23    # "$result":Ljava/lang/Object;
    goto/16 :goto_f

    .line 123
    .end local v23    # "$result":Ljava/lang/Object;
    .restart local v6    # "$result":Ljava/lang/Object;
    :catch_1
    move-exception v0

    move-object v9, v1

    move-object/from16 v23, v6

    move-object v1, v5

    move-object/from16 v3, v23

    .end local v6    # "$result":Ljava/lang/Object;
    .restart local v23    # "$result":Ljava/lang/Object;
    goto :goto_d

    .line 130
    .end local v23    # "$result":Ljava/lang/Object;
    .restart local v6    # "$result":Ljava/lang/Object;
    :catchall_13
    move-exception v0

    move-object v1, v5

    move-object v3, v6

    goto :goto_f

    .line 123
    :catch_2
    move-exception v0

    move-object v9, v1

    move-object v1, v5

    move-object v3, v6

    .line 124
    .end local v5    # "this":Lcom/rokid/security/phone/sdk/server/msg/file/FileSender$sendFile$2;
    .end local v6    # "$result":Ljava/lang/Object;
    .local v0, "e":Ljava/lang/Exception;
    .restart local v1    # "this":Lcom/rokid/security/phone/sdk/server/msg/file/FileSender$sendFile$2;
    .restart local v3    # "$result":Ljava/lang/Object;
    :goto_d
    :try_start_1a
    iget-object v2, v1, Lcom/rokid/security/phone/sdk/server/msg/file/FileSender$sendFile$2;->this$0:Lcom/rokid/security/phone/sdk/server/msg/file/FileSender;

    invoke-static {v2}, Lcom/rokid/security/phone/sdk/server/msg/file/FileSender;->access$getTAG$p(Lcom/rokid/security/phone/sdk/server/msg/file/FileSender;)Ljava/lang/String;

    move-result-object v2

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string v5, "flow=file src=phone stage=send event=failed type="

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v0}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v5

    invoke-virtual {v5}, Ljava/lang/Class;->getSimpleName()Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    filled-new-array {v4}, [Ljava/lang/Object;

    move-result-object v4

    invoke-static {v2, v4}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->e(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 125
    invoke-static {}, Lkotlinx/coroutines/Dispatchers;->getMain()Lkotlinx/coroutines/MainCoroutineDispatcher;

    move-result-object v2

    check-cast v2, Lkotlin/coroutines/CoroutineContext;

    new-instance v4, Lcom/rokid/security/phone/sdk/server/msg/file/FileSender$sendFile$2$3;

    iget-object v5, v1, Lcom/rokid/security/phone/sdk/server/msg/file/FileSender$sendFile$2;->$appListener:Lcom/rokid/security/phone/sdk/api/msg/listener/FileReceiveListener;

    iget-object v6, v1, Lcom/rokid/security/phone/sdk/server/msg/file/FileSender$sendFile$2;->$onResult:Lkotlin/jvm/functions/Function1;

    const/4 v7, 0x0

    invoke-direct {v4, v5, v6, v0, v7}, Lcom/rokid/security/phone/sdk/server/msg/file/FileSender$sendFile$2$3;-><init>(Lcom/rokid/security/phone/sdk/api/msg/listener/FileReceiveListener;Lkotlin/jvm/functions/Function1;Ljava/lang/Exception;Lkotlin/coroutines/Continuation;)V

    check-cast v4, Lkotlin/jvm/functions/Function2;

    move-object v5, v1

    check-cast v5, Lkotlin/coroutines/Continuation;

    iput-object v7, v1, Lcom/rokid/security/phone/sdk/server/msg/file/FileSender$sendFile$2;->L$0:Ljava/lang/Object;

    iput-object v7, v1, Lcom/rokid/security/phone/sdk/server/msg/file/FileSender$sendFile$2;->L$1:Ljava/lang/Object;

    iput-object v7, v1, Lcom/rokid/security/phone/sdk/server/msg/file/FileSender$sendFile$2;->L$2:Ljava/lang/Object;

    iput-object v7, v1, Lcom/rokid/security/phone/sdk/server/msg/file/FileSender$sendFile$2;->L$3:Ljava/lang/Object;

    iput-object v7, v1, Lcom/rokid/security/phone/sdk/server/msg/file/FileSender$sendFile$2;->L$4:Ljava/lang/Object;

    iput-object v7, v1, Lcom/rokid/security/phone/sdk/server/msg/file/FileSender$sendFile$2;->L$5:Ljava/lang/Object;

    iput-object v7, v1, Lcom/rokid/security/phone/sdk/server/msg/file/FileSender$sendFile$2;->L$6:Ljava/lang/Object;

    iput-object v7, v1, Lcom/rokid/security/phone/sdk/server/msg/file/FileSender$sendFile$2;->L$7:Ljava/lang/Object;

    iput-object v7, v1, Lcom/rokid/security/phone/sdk/server/msg/file/FileSender$sendFile$2;->L$8:Ljava/lang/Object;

    const/4 v6, 0x6

    iput v6, v1, Lcom/rokid/security/phone/sdk/server/msg/file/FileSender$sendFile$2;->label:I

    invoke-static {v2, v4, v5}, Lkotlinx/coroutines/BuildersKt;->withContext(Lkotlin/coroutines/CoroutineContext;Lkotlin/jvm/functions/Function2;Lkotlin/coroutines/Continuation;)Ljava/lang/Object;

    move-result-object v2
    :try_end_1a
    .catchall {:try_start_1a .. :try_end_1a} :catchall_0

    .end local v0    # "e":Ljava/lang/Exception;
    if-ne v2, v9, :cond_10

    .line 59
    return-object v9

    .line 130
    :cond_10
    :goto_e
    iget-object v0, v1, Lcom/rokid/security/phone/sdk/server/msg/file/FileSender$sendFile$2;->this$0:Lcom/rokid/security/phone/sdk/server/msg/file/FileSender;

    invoke-virtual {v0}, Lcom/rokid/security/phone/sdk/server/msg/file/FileSender;->disconnectSocket()V

    .line 131
    nop

    .line 132
    sget-object v0, Lkotlin/Unit;->INSTANCE:Lkotlin/Unit;

    return-object v0

    .line 130
    :goto_f
    iget-object v2, v1, Lcom/rokid/security/phone/sdk/server/msg/file/FileSender$sendFile$2;->this$0:Lcom/rokid/security/phone/sdk/server/msg/file/FileSender;

    invoke-virtual {v2}, Lcom/rokid/security/phone/sdk/server/msg/file/FileSender;->disconnectSocket()V

    throw v0

    :pswitch_data_0
    .packed-switch 0x0
        :pswitch_6
        :pswitch_5
        :pswitch_4
        :pswitch_3
        :pswitch_2
        :pswitch_1
        :pswitch_0
    .end packed-switch
.end method
