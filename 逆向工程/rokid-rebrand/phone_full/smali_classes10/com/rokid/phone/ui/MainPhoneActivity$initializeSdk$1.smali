.class final Lcom/rokid/phone/ui/MainPhoneActivity$initializeSdk$1;
.super Lkotlin/coroutines/jvm/internal/SuspendLambda;
.source "MainPhoneActivity.kt"

# interfaces
.implements Lkotlin/jvm/functions/Function2;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/rokid/phone/ui/MainPhoneActivity;->initializeSdk()V
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

.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000\n\n\u0000\n\u0002\u0010\u0002\n\u0002\u0018\u0002\u0010\u0000\u001a\u00020\u0001*\u00020\u0002H\n"
    }
    d2 = {
        "<anonymous>",
        "",
        "Lkotlinx/coroutines/CoroutineScope;"
    }
    k = 0x3
    mv = {
        0x2,
        0x2,
        0x0
    }
    xi = 0x30
.end annotation

.annotation runtime Lkotlin/coroutines/jvm/internal/DebugMetadata;
    c = "com.rokid.phone.ui.MainPhoneActivity$initializeSdk$1"
    f = "MainPhoneActivity.kt"
    i = {}
    l = {}
    m = "invokeSuspend"
    n = {}
    s = {}
.end annotation


# instance fields
.field label:I

.field final synthetic this$0:Lcom/rokid/phone/ui/MainPhoneActivity;


# direct methods
.method public static synthetic $r8$lambda$1KHBGrYyTZeI1MnS7A37jsgooE0(Lcom/rokid/security/phone/sdk/base/data/callback/IResult;Lcom/rokid/phone/ui/MainPhoneActivity;)V
    .locals 0

    invoke-static {p0, p1}, Lcom/rokid/phone/ui/MainPhoneActivity$initializeSdk$1;->invokeSuspend$lambda$1$lambda$0(Lcom/rokid/security/phone/sdk/base/data/callback/IResult;Lcom/rokid/phone/ui/MainPhoneActivity;)V

    return-void
.end method

.method public static synthetic $r8$lambda$agUOCDuQHK8cjShWCGDLC7ag0zQ(Lcom/rokid/phone/ui/MainPhoneActivity;Lcom/rokid/security/phone/sdk/base/data/callback/IResult;)Lkotlin/Unit;
    .locals 0

    invoke-static {p0, p1}, Lcom/rokid/phone/ui/MainPhoneActivity$initializeSdk$1;->invokeSuspend$lambda$1(Lcom/rokid/phone/ui/MainPhoneActivity;Lcom/rokid/security/phone/sdk/base/data/callback/IResult;)Lkotlin/Unit;

    move-result-object p0

    return-object p0
.end method

.method constructor <init>(Lcom/rokid/phone/ui/MainPhoneActivity;Lkotlin/coroutines/Continuation;)V
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lcom/rokid/phone/ui/MainPhoneActivity;",
            "Lkotlin/coroutines/Continuation<",
            "-",
            "Lcom/rokid/phone/ui/MainPhoneActivity$initializeSdk$1;",
            ">;)V"
        }
    .end annotation

    iput-object p1, p0, Lcom/rokid/phone/ui/MainPhoneActivity$initializeSdk$1;->this$0:Lcom/rokid/phone/ui/MainPhoneActivity;

    const/4 v0, 0x2

    invoke-direct {p0, v0, p2}, Lkotlin/coroutines/jvm/internal/SuspendLambda;-><init>(ILkotlin/coroutines/Continuation;)V

    return-void
.end method

.method private static final invokeSuspend$lambda$1(Lcom/rokid/phone/ui/MainPhoneActivity;Lcom/rokid/security/phone/sdk/base/data/callback/IResult;)Lkotlin/Unit;
    .locals 1
    .param p0, "this$0"    # Lcom/rokid/phone/ui/MainPhoneActivity;
    .param p1, "result"    # Lcom/rokid/security/phone/sdk/base/data/callback/IResult;

    .line 161
    new-instance v0, Lcom/rokid/phone/ui/MainPhoneActivity$initializeSdk$1$$ExternalSyntheticLambda0;

    invoke-direct {v0, p1, p0}, Lcom/rokid/phone/ui/MainPhoneActivity$initializeSdk$1$$ExternalSyntheticLambda0;-><init>(Lcom/rokid/security/phone/sdk/base/data/callback/IResult;Lcom/rokid/phone/ui/MainPhoneActivity;)V

    invoke-virtual {p0, v0}, Lcom/rokid/phone/ui/MainPhoneActivity;->runOnUiThread(Ljava/lang/Runnable;)V

    .line 169
    sget-object v0, Lkotlin/Unit;->INSTANCE:Lkotlin/Unit;

    return-object v0
.end method

.method private static final invokeSuspend$lambda$1$lambda$0(Lcom/rokid/security/phone/sdk/base/data/callback/IResult;Lcom/rokid/phone/ui/MainPhoneActivity;)V
    .locals 3
    .param p0, "$result"    # Lcom/rokid/security/phone/sdk/base/data/callback/IResult;
    .param p1, "this$0"    # Lcom/rokid/phone/ui/MainPhoneActivity;

    .line 162
    invoke-virtual {p0}, Lcom/rokid/security/phone/sdk/base/data/callback/IResult;->unbox-impl()Ljava/lang/Object;

    move-result-object v0

    invoke-static {v0}, Lcom/rokid/security/phone/sdk/base/data/callback/IResult;->isSuccess-impl(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_0

    .line 163
    invoke-static {p1}, Lcom/rokid/phone/ui/MainPhoneActivity;->access$onSdkReady(Lcom/rokid/phone/ui/MainPhoneActivity;)V

    goto :goto_0

    .line 165
    :cond_0
    invoke-static {p1}, Lcom/rokid/phone/ui/MainPhoneActivity;->access$getBinding(Lcom/rokid/phone/ui/MainPhoneActivity;)Lcom/rokid/phone/databinding/LayoutMainPhoneBinding;

    move-result-object v0

    iget-object v0, v0, Lcom/rokid/phone/databinding/LayoutMainPhoneBinding;->tvConnectionState:Landroid/widget/TextView;

    sget v1, Lcom/rokid/phone/R$string;->demo_sdk_init_failed:I

    const/4 v2, 0x0

    new-array v2, v2, [Ljava/lang/Object;

    invoke-static {v1, v2}, Lcom/rokid/phone/utils/DemoStringsKt;->demoString(I[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    check-cast v1, Ljava/lang/CharSequence;

    invoke-virtual {v0, v1}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 166
    const-string v0, "MainPhoneActivity"

    const-string v1, "Phone SDK initialization failed"

    invoke-static {v0, v1}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    .line 168
    :goto_0
    return-void
.end method


# virtual methods
.method public final create(Ljava/lang/Object;Lkotlin/coroutines/Continuation;)Lkotlin/coroutines/Continuation;
    .locals 2
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

    new-instance v0, Lcom/rokid/phone/ui/MainPhoneActivity$initializeSdk$1;

    iget-object v1, p0, Lcom/rokid/phone/ui/MainPhoneActivity$initializeSdk$1;->this$0:Lcom/rokid/phone/ui/MainPhoneActivity;

    invoke-direct {v0, v1, p2}, Lcom/rokid/phone/ui/MainPhoneActivity$initializeSdk$1;-><init>(Lcom/rokid/phone/ui/MainPhoneActivity;Lkotlin/coroutines/Continuation;)V

    check-cast v0, Lkotlin/coroutines/Continuation;

    return-object v0
.end method

.method public bridge synthetic invoke(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;
    .locals 1

    check-cast p1, Lkotlinx/coroutines/CoroutineScope;

    check-cast p2, Lkotlin/coroutines/Continuation;

    invoke-virtual {p0, p1, p2}, Lcom/rokid/phone/ui/MainPhoneActivity$initializeSdk$1;->invoke(Lkotlinx/coroutines/CoroutineScope;Lkotlin/coroutines/Continuation;)Ljava/lang/Object;

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

    invoke-virtual {p0, p1, p2}, Lcom/rokid/phone/ui/MainPhoneActivity$initializeSdk$1;->create(Ljava/lang/Object;Lkotlin/coroutines/Continuation;)Lkotlin/coroutines/Continuation;

    move-result-object v0

    check-cast v0, Lcom/rokid/phone/ui/MainPhoneActivity$initializeSdk$1;

    sget-object v1, Lkotlin/Unit;->INSTANCE:Lkotlin/Unit;

    invoke-virtual {v0, v1}, Lcom/rokid/phone/ui/MainPhoneActivity$initializeSdk$1;->invokeSuspend(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    return-object v0
.end method

.method public final invokeSuspend(Ljava/lang/Object;)Ljava/lang/Object;
    .locals 12
    .param p1, "$result"    # Ljava/lang/Object;

    invoke-static {}, Lkotlin/coroutines/intrinsics/IntrinsicsKt;->getCOROUTINE_SUSPENDED()Ljava/lang/Object;

    .line 153
    iget v0, p0, Lcom/rokid/phone/ui/MainPhoneActivity$initializeSdk$1;->label:I

    packed-switch v0, :pswitch_data_0

    new-instance v0, Ljava/lang/IllegalStateException;

    const-string v1, "call to \'resume\' before \'invoke\' with coroutine"

    invoke-direct {v0, v1}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/String;)V

    throw v0

    :pswitch_0
    invoke-static {p1}, Lkotlin/ResultKt;->throwOnFailure(Ljava/lang/Object;)V

    .line 155
    const/4 v0, 0x2

    new-array v0, v0, [Ljava/lang/String;

    const/4 v1, 0x0

    const-string v2, "SecurityPhone"

    aput-object v2, v0, v1

    const/4 v1, 0x1

    const-string v2, "GlassSample"

    aput-object v2, v0, v1

    invoke-static {v0}, Lkotlin/collections/CollectionsKt;->arrayListOf([Ljava/lang/Object;)Ljava/util/ArrayList;

    move-result-object v4

    .line 156
    new-instance v8, Lcom/rokid/security/phone/sdk/base/data/UserAuthInfo;

    const-string v0, ""

    invoke-direct {v8, v0, v0}, Lcom/rokid/security/phone/sdk/base/data/UserAuthInfo;-><init>(Ljava/lang/String;Ljava/lang/String;)V

    .line 157
    sget-object v0, Lcom/rokid/security/phone/sdk/base/data/NetServiceType;->TranslateService:Lcom/rokid/security/phone/sdk/base/data/NetServiceType;

    invoke-static {v0}, Lkotlin/collections/CollectionsKt;->listOf(Ljava/lang/Object;)Ljava/util/List;

    move-result-object v9

    .line 154
    new-instance v0, Lcom/rokid/security/phone/sdk/base/data/EngineParam;

    .line 155
    nop

    .line 154
    nop

    .line 158
    nop

    .line 154
    nop

    .line 156
    nop

    .line 157
    nop

    .line 154
    const/16 v10, 0xa

    const/4 v11, 0x0

    const/4 v5, 0x0

    const-string v6, "public"

    const/4 v7, 0x0

    move-object v3, v0

    invoke-direct/range {v3 .. v11}, Lcom/rokid/security/phone/sdk/base/data/EngineParam;-><init>(Ljava/util/ArrayList;Lcom/rokid/security/phone/sdk/base/data/ServiceBusConfig;Ljava/lang/String;Ljava/lang/String;Lcom/rokid/security/phone/sdk/base/data/UserAuthInfo;Ljava/util/List;ILkotlin/jvm/internal/DefaultConstructorMarker;)V

    .line 160
    .local v0, "param":Lcom/rokid/security/phone/sdk/base/data/EngineParam;
    iget-object v1, p0, Lcom/rokid/phone/ui/MainPhoneActivity$initializeSdk$1;->this$0:Lcom/rokid/phone/ui/MainPhoneActivity;

    invoke-static {v1}, Lcom/rokid/phone/ui/MainPhoneActivity;->access$getPhoneEngineService(Lcom/rokid/phone/ui/MainPhoneActivity;)Lcom/rokid/security/phone/sdk/api/engine/api/AbsMobileEngineService;

    move-result-object v1

    iget-object v2, p0, Lcom/rokid/phone/ui/MainPhoneActivity$initializeSdk$1;->this$0:Lcom/rokid/phone/ui/MainPhoneActivity;

    new-instance v3, Lcom/rokid/phone/ui/MainPhoneActivity$initializeSdk$1$$ExternalSyntheticLambda1;

    invoke-direct {v3, v2}, Lcom/rokid/phone/ui/MainPhoneActivity$initializeSdk$1$$ExternalSyntheticLambda1;-><init>(Lcom/rokid/phone/ui/MainPhoneActivity;)V

    invoke-virtual {v1, v0, v3}, Lcom/rokid/security/phone/sdk/api/engine/api/AbsMobileEngineService;->initSDK(Lcom/rokid/security/phone/sdk/base/data/EngineParam;Lkotlin/jvm/functions/Function1;)V

    .line 170
    sget-object v1, Lkotlin/Unit;->INSTANCE:Lkotlin/Unit;

    return-object v1

    nop

    :pswitch_data_0
    .packed-switch 0x0
        :pswitch_0
    .end packed-switch
.end method
