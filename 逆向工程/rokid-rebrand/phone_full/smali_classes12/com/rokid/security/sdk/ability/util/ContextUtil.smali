.class public final Lcom/rokid/security/sdk/ability/util/ContextUtil;
.super Ljava/lang/Object;
.source "ContextUtil.kt"


# annotations
.annotation system Ldalvik/annotation/SourceDebugExtension;
    value = "SMAP\nContextUtil.kt\nKotlin\n*S Kotlin\n*F\n+ 1 ContextUtil.kt\ncom/rokid/security/sdk/ability/util/ContextUtil\n+ 2 fake.kt\nkotlin/jvm/internal/FakeKt\n*L\n1#1,47:1\n1#2:48\n*E\n"
.end annotation

.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000*\n\u0002\u0018\u0002\n\u0002\u0010\u0000\n\u0002\u0008\u0002\n\u0002\u0018\u0002\n\u0000\n\u0002\u0010%\n\u0002\u0010\u0008\n\u0002\u0010\u000b\n\u0002\u0008\u0003\n\u0002\u0010\u0002\n\u0002\u0008\u0002\u0008\u00c6\u0002\u0018\u00002\u00020\u0001B\u0007\u0008\u0002\u00a2\u0006\u0002\u0010\u0002J\u0008\u0010\t\u001a\u00020\u0004H\u0007J\u0006\u0010\n\u001a\u00020\u0008J\u000e\u0010\u000b\u001a\u00020\u000c2\u0006\u0010\r\u001a\u00020\u0008R\u0010\u0010\u0003\u001a\u0004\u0018\u00010\u0004X\u0082\u000e\u00a2\u0006\u0002\n\u0000R\u001a\u0010\u0005\u001a\u000e\u0012\u0004\u0012\u00020\u0007\u0012\u0004\u0012\u00020\u00080\u0006X\u0082\u0004\u00a2\u0006\u0002\n\u0000\u00a8\u0006\u000e"
    }
    d2 = {
        "Lcom/rokid/security/sdk/ability/util/ContextUtil;",
        "",
        "()V",
        "application",
        "Landroid/app/Application;",
        "mapInterceptAppVoiceInstruct",
        "",
        "",
        "",
        "getApplicationContext",
        "getInterceptAppVoiceInstruct",
        "setInterceptAppVoiceInstruct",
        "",
        "intercept",
        "sdk-common-ability_release"
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
.field public static final INSTANCE:Lcom/rokid/security/sdk/ability/util/ContextUtil;

.field private static application:Landroid/app/Application;

.field private static final mapInterceptAppVoiceInstruct:Ljava/util/Map;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/Map<",
            "Ljava/lang/Integer;",
            "Ljava/lang/Boolean;",
            ">;"
        }
    .end annotation
.end field


# direct methods
.method static constructor <clinit>()V
    .locals 1

    new-instance v0, Lcom/rokid/security/sdk/ability/util/ContextUtil;

    invoke-direct {v0}, Lcom/rokid/security/sdk/ability/util/ContextUtil;-><init>()V

    sput-object v0, Lcom/rokid/security/sdk/ability/util/ContextUtil;->INSTANCE:Lcom/rokid/security/sdk/ability/util/ContextUtil;

    .line 13
    new-instance v0, Ljava/util/LinkedHashMap;

    invoke-direct {v0}, Ljava/util/LinkedHashMap;-><init>()V

    check-cast v0, Ljava/util/Map;

    sput-object v0, Lcom/rokid/security/sdk/ability/util/ContextUtil;->mapInterceptAppVoiceInstruct:Ljava/util/Map;

    return-void
.end method

.method private constructor <init>()V
    .locals 0

    .line 11
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static final getApplicationContext()Landroid/app/Application;
    .locals 7
    .annotation runtime Lkotlin/jvm/JvmStatic;
    .end annotation

    .line 17
    sget-object v0, Lcom/rokid/security/sdk/ability/util/ContextUtil;->application:Landroid/app/Application;

    if-eqz v0, :cond_0

    .line 18
    sget-object v0, Lcom/rokid/security/sdk/ability/util/ContextUtil;->application:Landroid/app/Application;

    invoke-static {v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNull(Ljava/lang/Object;)V

    return-object v0

    .line 20
    :cond_0
    const/4 v0, 0x0

    .line 22
    .local v0, "app":Landroid/app/Application;
    nop

    .line 23
    const/4 v1, 0x0

    const/4 v2, 0x0

    :try_start_0
    const-string v3, "android.app.AppGlobals"

    invoke-static {v3}, Ljava/lang/Class;->forName(Ljava/lang/String;)Ljava/lang/Class;

    move-result-object v3

    const-string v4, "getInitialApplication"

    new-array v5, v2, [Ljava/lang/Class;

    invoke-virtual {v3, v4, v5}, Ljava/lang/Class;->getMethod(Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    move-result-object v3

    new-array v4, v2, [Ljava/lang/Object;

    invoke-virtual {v3, v1, v4}, Ljava/lang/reflect/Method;->invoke(Ljava/lang/Object;[Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Landroid/app/Application;

    move-object v0, v3

    .line 24
    if-eqz v0, :cond_1

    .line 31
    goto :goto_1

    .line 48
    :cond_1
    const/4 v3, 0x0

    .line 24
    .local v3, "$i$a$-checkNotNull-ContextUtil$getApplicationContext$1":I
    const-string v4, "Static initialization of Applications must be on main thread."

    .end local v3    # "$i$a$-checkNotNull-ContextUtil$getApplicationContext$1":I
    new-instance v3, Ljava/lang/IllegalStateException;

    invoke-virtual {v4}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object v4

    invoke-direct {v3, v4}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/String;)V

    .end local v0    # "app":Landroid/app/Application;
    throw v3
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 31
    .restart local v0    # "app":Landroid/app/Application;
    :catchall_0
    move-exception v1

    goto :goto_0

    .line 25
    :catch_0
    move-exception v3

    .line 26
    .local v3, "var8":Ljava/lang/Exception;
    nop

    .line 27
    :try_start_1
    const-string v4, "android.app.ActivityThread"

    invoke-static {v4}, Ljava/lang/Class;->forName(Ljava/lang/String;)Ljava/lang/Class;

    move-result-object v4

    const-string v5, "currentApplication"

    new-array v6, v2, [Ljava/lang/Class;

    invoke-virtual {v4, v5, v6}, Ljava/lang/Class;->getMethod(Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    move-result-object v4

    new-array v2, v2, [Ljava/lang/Object;

    invoke-virtual {v4, v1, v2}, Ljava/lang/reflect/Method;->invoke(Ljava/lang/Object;[Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Landroid/app/Application;
    :try_end_1
    .catch Ljava/lang/Exception; {:try_start_1 .. :try_end_1} :catch_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    move-object v0, v1

    goto :goto_1

    .line 31
    .end local v3    # "var8":Ljava/lang/Exception;
    :goto_0
    sput-object v0, Lcom/rokid/security/sdk/ability/util/ContextUtil;->application:Landroid/app/Application;

    throw v1

    .line 28
    .restart local v3    # "var8":Ljava/lang/Exception;
    :catch_1
    move-exception v1

    .line 31
    .end local v3    # "var8":Ljava/lang/Exception;
    :goto_1
    sput-object v0, Lcom/rokid/security/sdk/ability/util/ContextUtil;->application:Landroid/app/Application;

    .line 32
    nop

    .line 34
    sget-object v1, Lcom/rokid/security/sdk/ability/util/ContextUtil;->application:Landroid/app/Application;

    invoke-static {v1}, Lkotlin/jvm/internal/Intrinsics;->checkNotNull(Ljava/lang/Object;)V

    return-object v1
.end method


# virtual methods
.method public final getInterceptAppVoiceInstruct()Z
    .locals 2

    .line 43
    sget-object v0, Lcom/rokid/security/sdk/ability/util/ContextUtil;->mapInterceptAppVoiceInstruct:Ljava/util/Map;

    invoke-static {}, Landroid/os/Binder;->getCallingPid()I

    move-result v1

    invoke-static {v1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v1

    invoke-interface {v0, v1}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    const/4 v1, 0x1

    invoke-static {v1}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v1

    invoke-static {v0, v1}, Lkotlin/jvm/internal/Intrinsics;->areEqual(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v0

    return v0
.end method

.method public final setInterceptAppVoiceInstruct(Z)V
    .locals 3
    .param p1, "intercept"    # Z

    invoke-static {p1}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v0

    .line 39
    sget-object v1, Lcom/rokid/security/sdk/ability/util/ContextUtil;->mapInterceptAppVoiceInstruct:Ljava/util/Map;

    invoke-static {}, Landroid/os/Binder;->getCallingPid()I

    move-result v2

    invoke-static {v2}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v2

    invoke-interface {v1, v2, v0}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 40
    return-void
.end method
