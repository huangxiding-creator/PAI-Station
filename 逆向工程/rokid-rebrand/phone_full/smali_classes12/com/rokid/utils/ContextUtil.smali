.class public Lcom/rokid/utils/ContextUtil;
.super Ljava/lang/Object;
.source "ContextUtil.java"


# static fields
.field private static application:Landroid/app/Application;


# direct methods
.method public constructor <init>()V
    .locals 0

    .line 7
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static getApplicationContext()Landroid/app/Application;
    .locals 7

    .line 12
    sget-object v0, Lcom/rokid/utils/ContextUtil;->application:Landroid/app/Application;

    if-eqz v0, :cond_0

    .line 13
    sget-object v0, Lcom/rokid/utils/ContextUtil;->application:Landroid/app/Application;

    return-object v0

    .line 15
    :cond_0
    const/4 v0, 0x0

    .line 17
    .local v0, "app":Landroid/app/Application;
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

    .line 18
    if-eqz v0, :cond_1

    .line 26
    goto :goto_1

    .line 19
    :cond_1
    new-instance v3, Ljava/lang/IllegalStateException;

    const-string v4, "Static initialization of Applications must be on main thread."

    invoke-direct {v3, v4}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/String;)V

    .end local v0    # "app":Landroid/app/Application;
    throw v3
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 26
    .restart local v0    # "app":Landroid/app/Application;
    :catchall_0
    move-exception v1

    goto :goto_0

    .line 20
    :catch_0
    move-exception v3

    .line 22
    .local v3, "e":Ljava/lang/Exception;
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

    .line 24
    goto :goto_1

    .line 26
    .end local v3    # "e":Ljava/lang/Exception;
    :goto_0
    sput-object v0, Lcom/rokid/utils/ContextUtil;->application:Landroid/app/Application;

    .line 27
    throw v1

    .line 23
    .restart local v3    # "e":Ljava/lang/Exception;
    :catch_1
    move-exception v1

    .line 26
    .end local v3    # "e":Ljava/lang/Exception;
    :goto_1
    sput-object v0, Lcom/rokid/utils/ContextUtil;->application:Landroid/app/Application;

    .line 27
    nop

    .line 28
    sget-object v1, Lcom/rokid/utils/ContextUtil;->application:Landroid/app/Application;

    return-object v1
.end method
