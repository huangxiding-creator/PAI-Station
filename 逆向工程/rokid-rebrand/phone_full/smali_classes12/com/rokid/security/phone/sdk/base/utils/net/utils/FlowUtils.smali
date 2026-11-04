.class public final Lcom/rokid/security/phone/sdk/base/utils/net/utils/FlowUtils;
.super Ljava/lang/Object;
.source "FlowUtils.kt"


# annotations
.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000 \n\u0002\u0018\u0002\n\u0002\u0010\u0000\n\u0002\u0008\u0002\n\u0002\u0018\u0002\n\u0002\u0018\u0002\n\u0002\u0008\u0005\n\u0002\u0018\u0002\n\u0002\u0008\u0004\u0008\u00c6\u0002\u0018\u00002\u00020\u0001B\u0007\u0008\u0002\u00a2\u0006\u0002\u0010\u0002JK\u0010\u0003\u001a\u0014\u0012\u0010\u0012\u000e\u0012\u0004\u0012\u0002H\u0006\u0012\u0004\u0012\u0002H\u00070\u00050\u0004\"\u0004\u0008\u0000\u0010\u0006\"\u0004\u0008\u0001\u0010\u00072\u000c\u0010\u0008\u001a\u0008\u0012\u0004\u0012\u0002H\u00060\u00042\u000c\u0010\t\u001a\u0008\u0012\u0004\u0012\u0002H\u00070\u0004H\u0086@\u00f8\u0001\u0000\u00a2\u0006\u0002\u0010\nJe\u0010\u0003\u001a\u001a\u0012\u0016\u0012\u0014\u0012\u0004\u0012\u0002H\u0006\u0012\u0004\u0012\u0002H\u0007\u0012\u0004\u0012\u0002H\u000c0\u000b0\u0004\"\u0004\u0008\u0000\u0010\u0006\"\u0004\u0008\u0001\u0010\u0007\"\u0004\u0008\u0002\u0010\u000c2\u000c\u0010\u0008\u001a\u0008\u0012\u0004\u0012\u0002H\u00060\u00042\u000c\u0010\t\u001a\u0008\u0012\u0004\u0012\u0002H\u00070\u00042\u000c\u0010\r\u001a\u0008\u0012\u0004\u0012\u0002H\u000c0\u0004H\u0086@\u00f8\u0001\u0000\u00a2\u0006\u0002\u0010\u000e\u0082\u0002\u0004\n\u0002\u0008\u0019\u00a8\u0006\u000f"
    }
    d2 = {
        "Lcom/rokid/security/phone/sdk/base/utils/net/utils/FlowUtils;",
        "",
        "()V",
        "combineResults",
        "Lkotlinx/coroutines/flow/Flow;",
        "Lkotlin/Pair;",
        "T1",
        "T2",
        "flow1",
        "flow2",
        "(Lkotlinx/coroutines/flow/Flow;Lkotlinx/coroutines/flow/Flow;Lkotlin/coroutines/Continuation;)Ljava/lang/Object;",
        "Lkotlin/Triple;",
        "T3",
        "flow3",
        "(Lkotlinx/coroutines/flow/Flow;Lkotlinx/coroutines/flow/Flow;Lkotlinx/coroutines/flow/Flow;Lkotlin/coroutines/Continuation;)Ljava/lang/Object;",
        "base-utils_release"
    }
    k = 0x1
    mv = {
        0x1,
        0x8,
        0x0
    }
    xi = 0x30
.end annotation


# static fields
.field public static final INSTANCE:Lcom/rokid/security/phone/sdk/base/utils/net/utils/FlowUtils;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    new-instance v0, Lcom/rokid/security/phone/sdk/base/utils/net/utils/FlowUtils;

    invoke-direct {v0}, Lcom/rokid/security/phone/sdk/base/utils/net/utils/FlowUtils;-><init>()V

    sput-object v0, Lcom/rokid/security/phone/sdk/base/utils/net/utils/FlowUtils;->INSTANCE:Lcom/rokid/security/phone/sdk/base/utils/net/utils/FlowUtils;

    return-void
.end method

.method private constructor <init>()V
    .locals 0

    .line 9
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public final combineResults(Lkotlinx/coroutines/flow/Flow;Lkotlinx/coroutines/flow/Flow;Lkotlin/coroutines/Continuation;)Ljava/lang/Object;
    .locals 2
    .param p1, "flow1"    # Lkotlinx/coroutines/flow/Flow;
    .param p2, "flow2"    # Lkotlinx/coroutines/flow/Flow;
    .param p3, "$completion"    # Lkotlin/coroutines/Continuation;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "<T1:",
            "Ljava/lang/Object;",
            "T2:",
            "Ljava/lang/Object;",
            ">(",
            "Lkotlinx/coroutines/flow/Flow<",
            "+TT1;>;",
            "Lkotlinx/coroutines/flow/Flow<",
            "+TT2;>;",
            "Lkotlin/coroutines/Continuation<",
            "-",
            "Lkotlinx/coroutines/flow/Flow<",
            "+",
            "Lkotlin/Pair<",
            "+TT1;+TT2;>;>;>;)",
            "Ljava/lang/Object;"
        }
    .end annotation

    .line 25
    new-instance v0, Lcom/rokid/security/phone/sdk/base/utils/net/utils/FlowUtils$combineResults$4;

    const/4 v1, 0x0

    invoke-direct {v0, v1}, Lcom/rokid/security/phone/sdk/base/utils/net/utils/FlowUtils$combineResults$4;-><init>(Lkotlin/coroutines/Continuation;)V

    check-cast v0, Lkotlin/jvm/functions/Function3;

    invoke-static {p1, p2, v0}, Lkotlinx/coroutines/flow/FlowKt;->combine(Lkotlinx/coroutines/flow/Flow;Lkotlinx/coroutines/flow/Flow;Lkotlin/jvm/functions/Function3;)Lkotlinx/coroutines/flow/Flow;

    move-result-object v0

    return-object v0
.end method

.method public final combineResults(Lkotlinx/coroutines/flow/Flow;Lkotlinx/coroutines/flow/Flow;Lkotlinx/coroutines/flow/Flow;Lkotlin/coroutines/Continuation;)Ljava/lang/Object;
    .locals 2
    .param p1, "flow1"    # Lkotlinx/coroutines/flow/Flow;
    .param p2, "flow2"    # Lkotlinx/coroutines/flow/Flow;
    .param p3, "flow3"    # Lkotlinx/coroutines/flow/Flow;
    .param p4, "$completion"    # Lkotlin/coroutines/Continuation;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "<T1:",
            "Ljava/lang/Object;",
            "T2:",
            "Ljava/lang/Object;",
            "T3:",
            "Ljava/lang/Object;",
            ">(",
            "Lkotlinx/coroutines/flow/Flow<",
            "+TT1;>;",
            "Lkotlinx/coroutines/flow/Flow<",
            "+TT2;>;",
            "Lkotlinx/coroutines/flow/Flow<",
            "+TT3;>;",
            "Lkotlin/coroutines/Continuation<",
            "-",
            "Lkotlinx/coroutines/flow/Flow<",
            "+",
            "Lkotlin/Triple<",
            "+TT1;+TT2;+TT3;>;>;>;)",
            "Ljava/lang/Object;"
        }
    .end annotation

    .line 16
    new-instance v0, Lcom/rokid/security/phone/sdk/base/utils/net/utils/FlowUtils$combineResults$2;

    const/4 v1, 0x0

    invoke-direct {v0, v1}, Lcom/rokid/security/phone/sdk/base/utils/net/utils/FlowUtils$combineResults$2;-><init>(Lkotlin/coroutines/Continuation;)V

    check-cast v0, Lkotlin/jvm/functions/Function4;

    invoke-static {p1, p2, p3, v0}, Lkotlinx/coroutines/flow/FlowKt;->combine(Lkotlinx/coroutines/flow/Flow;Lkotlinx/coroutines/flow/Flow;Lkotlinx/coroutines/flow/Flow;Lkotlin/jvm/functions/Function4;)Lkotlinx/coroutines/flow/Flow;

    move-result-object v0

    return-object v0
.end method
