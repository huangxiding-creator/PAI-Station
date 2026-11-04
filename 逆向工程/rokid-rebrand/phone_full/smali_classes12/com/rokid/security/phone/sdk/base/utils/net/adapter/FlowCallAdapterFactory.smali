.class public final Lcom/rokid/security/phone/sdk/base/utils/net/adapter/FlowCallAdapterFactory;
.super Lretrofit2/CallAdapter$Factory;
.source "FlowCallAdapterFactory.kt"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/rokid/security/phone/sdk/base/utils/net/adapter/FlowCallAdapterFactory$Companion;
    }
.end annotation

.annotation system Ldalvik/annotation/SourceDebugExtension;
    value = "SMAP\nFlowCallAdapterFactory.kt\nKotlin\n*S Kotlin\n*F\n+ 1 FlowCallAdapterFactory.kt\ncom/rokid/security/phone/sdk/base/utils/net/adapter/FlowCallAdapterFactory\n+ 2 fake.kt\nkotlin/jvm/internal/FakeKt\n*L\n1#1,42:1\n1#2:43\n*E\n"
.end annotation

.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000*\n\u0002\u0018\u0002\n\u0002\u0018\u0002\n\u0002\u0008\u0002\n\u0002\u0018\u0002\n\u0000\n\u0002\u0018\u0002\n\u0000\n\u0002\u0010\u0011\n\u0002\u0010\u001b\n\u0000\n\u0002\u0018\u0002\n\u0002\u0008\u0003\u0018\u0000 \r2\u00020\u0001:\u0001\rB\u0005\u00a2\u0006\u0002\u0010\u0002J6\u0010\u0003\u001a\u000c\u0012\u0002\u0008\u0003\u0012\u0002\u0008\u0003\u0018\u00010\u00042\u0006\u0010\u0005\u001a\u00020\u00062\u000c\u0010\u0007\u001a\u0008\u0012\u0004\u0012\u00020\t0\u00082\u0006\u0010\n\u001a\u00020\u000bH\u0096\u0002\u00a2\u0006\u0002\u0010\u000c\u00a8\u0006\u000e"
    }
    d2 = {
        "Lcom/rokid/security/phone/sdk/base/utils/net/adapter/FlowCallAdapterFactory;",
        "Lretrofit2/CallAdapter$Factory;",
        "()V",
        "get",
        "Lretrofit2/CallAdapter;",
        "returnType",
        "Ljava/lang/reflect/Type;",
        "annotations",
        "",
        "",
        "retrofit",
        "Lretrofit2/Retrofit;",
        "(Ljava/lang/reflect/Type;[Ljava/lang/annotation/Annotation;Lretrofit2/Retrofit;)Lretrofit2/CallAdapter;",
        "Companion",
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
.field public static final Companion:Lcom/rokid/security/phone/sdk/base/utils/net/adapter/FlowCallAdapterFactory$Companion;


# direct methods
.method static constructor <clinit>()V
    .locals 2

    new-instance v0, Lcom/rokid/security/phone/sdk/base/utils/net/adapter/FlowCallAdapterFactory$Companion;

    const/4 v1, 0x0

    invoke-direct {v0, v1}, Lcom/rokid/security/phone/sdk/base/utils/net/adapter/FlowCallAdapterFactory$Companion;-><init>(Lkotlin/jvm/internal/DefaultConstructorMarker;)V

    sput-object v0, Lcom/rokid/security/phone/sdk/base/utils/net/adapter/FlowCallAdapterFactory;->Companion:Lcom/rokid/security/phone/sdk/base/utils/net/adapter/FlowCallAdapterFactory$Companion;

    return-void
.end method

.method public constructor <init>()V
    .locals 0

    .line 13
    invoke-direct {p0}, Lretrofit2/CallAdapter$Factory;-><init>()V

    return-void
.end method

.method public static final create()Lcom/rokid/security/phone/sdk/base/utils/net/adapter/FlowCallAdapterFactory;
    .locals 1
    .annotation runtime Lkotlin/jvm/JvmStatic;
    .end annotation

    sget-object v0, Lcom/rokid/security/phone/sdk/base/utils/net/adapter/FlowCallAdapterFactory;->Companion:Lcom/rokid/security/phone/sdk/base/utils/net/adapter/FlowCallAdapterFactory$Companion;

    invoke-virtual {v0}, Lcom/rokid/security/phone/sdk/base/utils/net/adapter/FlowCallAdapterFactory$Companion;->create()Lcom/rokid/security/phone/sdk/base/utils/net/adapter/FlowCallAdapterFactory;

    move-result-object v0

    return-object v0
.end method


# virtual methods
.method public get(Ljava/lang/reflect/Type;[Ljava/lang/annotation/Annotation;Lretrofit2/Retrofit;)Lretrofit2/CallAdapter;
    .locals 5
    .param p1, "returnType"    # Ljava/lang/reflect/Type;
    .param p2, "annotations"    # [Ljava/lang/annotation/Annotation;
    .param p3, "retrofit"    # Lretrofit2/Retrofit;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/reflect/Type;",
            "[",
            "Ljava/lang/annotation/Annotation;",
            "Lretrofit2/Retrofit;",
            ")",
            "Lretrofit2/CallAdapter<",
            "**>;"
        }
    .end annotation

    const-string v0, "returnType"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    const-string v0, "annotations"

    invoke-static {p2, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    const-string v0, "retrofit"

    invoke-static {p3, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 19
    invoke-static {p1}, Lretrofit2/CallAdapter$Factory;->getRawType(Ljava/lang/reflect/Type;)Ljava/lang/Class;

    move-result-object v0

    const-class v1, Lkotlinx/coroutines/flow/Flow;

    invoke-static {v0, v1}, Lkotlin/jvm/internal/Intrinsics;->areEqual(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v0

    if-nez v0, :cond_0

    .line 20
    const/4 v0, 0x0

    return-object v0

    .line 22
    :cond_0
    instance-of v0, p1, Ljava/lang/reflect/ParameterizedType;

    if-eqz v0, :cond_3

    .line 23
    move-object v0, p1

    check-cast v0, Ljava/lang/reflect/ParameterizedType;

    const/4 v1, 0x0

    invoke-static {v1, v0}, Lretrofit2/CallAdapter$Factory;->getParameterUpperBound(ILjava/lang/reflect/ParameterizedType;)Ljava/lang/reflect/Type;

    move-result-object v0

    .line 24
    .local v0, "responseType":Ljava/lang/reflect/Type;
    invoke-static {v0}, Lretrofit2/CallAdapter$Factory;->getRawType(Ljava/lang/reflect/Type;)Ljava/lang/Class;

    move-result-object v2

    .line 25
    .local v2, "rawFlowType":Ljava/lang/Class;
    const-class v3, Lokhttp3/Response;

    invoke-static {v2, v3}, Lkotlin/jvm/internal/Intrinsics;->areEqual(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v3

    if-eqz v3, :cond_2

    .line 26
    instance-of v3, v0, Ljava/lang/reflect/ParameterizedType;

    if-eqz v3, :cond_1

    .line 27
    new-instance v3, Lcom/rokid/security/phone/sdk/base/utils/net/adapter/ResponseCallAdapter;

    .line 29
    nop

    .line 30
    move-object v4, v0

    check-cast v4, Ljava/lang/reflect/ParameterizedType;

    .line 28
    invoke-static {v1, v4}, Lretrofit2/CallAdapter$Factory;->getParameterUpperBound(ILjava/lang/reflect/ParameterizedType;)Ljava/lang/reflect/Type;

    move-result-object v1

    .line 30
    const-string v4, "getParameterUpperBound(\n\u2026nseType\n                )"

    invoke-static {v1, v4}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    .line 27
    invoke-direct {v3, v1}, Lcom/rokid/security/phone/sdk/base/utils/net/adapter/ResponseCallAdapter;-><init>(Ljava/lang/reflect/Type;)V

    check-cast v3, Lretrofit2/CallAdapter;

    goto :goto_0

    .line 43
    :cond_1
    const/4 v1, 0x0

    .line 26
    .local v1, "$i$a$-check-FlowCallAdapterFactory$get$2":I
    nop

    .end local v1    # "$i$a$-check-FlowCallAdapterFactory$get$2":I
    new-instance v1, Ljava/lang/IllegalStateException;

    const-string v3, "Response must be parameterized as Response<T> or Response<out T>"

    invoke-virtual {v3}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object v3

    invoke-direct {v1, v3}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/String;)V

    throw v1

    .line 34
    :cond_2
    new-instance v1, Lcom/rokid/security/phone/sdk/base/utils/net/adapter/BodyCallAdapter;

    const-string v3, "responseType"

    invoke-static {v0, v3}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    invoke-direct {v1, v0}, Lcom/rokid/security/phone/sdk/base/utils/net/adapter/BodyCallAdapter;-><init>(Ljava/lang/reflect/Type;)V

    move-object v3, v1

    check-cast v3, Lretrofit2/CallAdapter;

    .line 25
    :goto_0
    return-object v3

    .line 43
    .end local v0    # "responseType":Ljava/lang/reflect/Type;
    .end local v2    # "rawFlowType":Ljava/lang/Class;
    :cond_3
    const/4 v0, 0x0

    .line 22
    .local v0, "$i$a$-check-FlowCallAdapterFactory$get$1":I
    nop

    .end local v0    # "$i$a$-check-FlowCallAdapterFactory$get$1":I
    new-instance v0, Ljava/lang/IllegalStateException;

    const-string v1, "Flow return type must be parameterized as Flow<T> or Flow<out T>"

    invoke-virtual {v1}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-direct {v0, v1}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/String;)V

    throw v0
.end method
