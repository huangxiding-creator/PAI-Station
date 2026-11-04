.class public Lcom/rokid/utils/QuietReflector;
.super Lcom/rokid/utils/Reflector;
.source "QuietReflector.java"


# direct methods
.method private constructor <init>()V
    .locals 0

    .line 18
    invoke-direct {p0}, Lcom/rokid/utils/Reflector;-><init>()V

    .line 19
    return-void
.end method

.method public static on(Ljava/lang/Class;)Lcom/rokid/utils/QuietReflector;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/Class<",
            "*>;)",
            "Lcom/rokid/utils/QuietReflector;"
        }
    .end annotation

    .line 36
    .local p0, "type":Ljava/lang/Class;, "Ljava/lang/Class<*>;"
    new-instance v0, Lcom/rokid/utils/QuietReflector;

    invoke-direct {v0}, Lcom/rokid/utils/QuietReflector;-><init>()V

    .line 37
    .local v0, "reflector":Lcom/rokid/utils/QuietReflector;
    iput-object p0, v0, Lcom/rokid/utils/QuietReflector;->mType:Ljava/lang/Class;

    .line 38
    return-object v0
.end method

.method public static on(Ljava/lang/String;)Lcom/rokid/utils/QuietReflector;
    .locals 1
    .param p0, "className"    # Ljava/lang/String;

    .line 22
    const-class v0, Lcom/rokid/utils/Reflector;

    invoke-virtual {v0}, Ljava/lang/Class;->getClassLoader()Ljava/lang/ClassLoader;

    move-result-object v0

    invoke-static {p0, v0}, Lcom/rokid/utils/QuietReflector;->on(Ljava/lang/String;Ljava/lang/ClassLoader;)Lcom/rokid/utils/QuietReflector;

    move-result-object v0

    return-object v0
.end method

.method public static on(Ljava/lang/String;Ljava/lang/ClassLoader;)Lcom/rokid/utils/QuietReflector;
    .locals 1
    .param p0, "className"    # Ljava/lang/String;
    .param p1, "loader"    # Ljava/lang/ClassLoader;

    .line 27
    const/4 v0, 0x1

    :try_start_0
    invoke-static {p0, v0, p1}, Ljava/lang/Class;->forName(Ljava/lang/String;ZLjava/lang/ClassLoader;)Ljava/lang/Class;

    move-result-object v0

    invoke-static {v0}, Lcom/rokid/utils/QuietReflector;->on(Ljava/lang/Class;)Lcom/rokid/utils/QuietReflector;

    move-result-object v0
    :try_end_0
    .catch Ljava/lang/ClassNotFoundException; {:try_start_0 .. :try_end_0} :catch_0

    return-object v0

    .line 28
    :catch_0
    move-exception v0

    .line 29
    .local v0, "e":Ljava/lang/ClassNotFoundException;
    invoke-virtual {v0}, Ljava/lang/ClassNotFoundException;->printStackTrace()V

    .line 32
    .end local v0    # "e":Ljava/lang/ClassNotFoundException;
    const/4 v0, 0x0

    return-object v0
.end method

.method public static with(Ljava/lang/Object;)Lcom/rokid/utils/QuietReflector;
    .locals 1
    .param p0, "caller"    # Ljava/lang/Object;

    .line 42
    invoke-virtual {p0}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v0

    invoke-static {v0}, Lcom/rokid/utils/QuietReflector;->on(Ljava/lang/Class;)Lcom/rokid/utils/QuietReflector;

    move-result-object v0

    .line 43
    invoke-virtual {v0, p0}, Lcom/rokid/utils/QuietReflector;->bind(Ljava/lang/Object;)Lcom/rokid/utils/QuietReflector;

    move-result-object v0

    .line 42
    return-object v0
.end method


# virtual methods
.method public bind(Ljava/lang/Object;)Lcom/rokid/utils/QuietReflector;
    .locals 1
    .param p1, "caller"    # Ljava/lang/Object;

    .line 49
    :try_start_0
    invoke-super {p0, p1}, Lcom/rokid/utils/Reflector;->bind(Ljava/lang/Object;)Lcom/rokid/utils/Reflector;
    :try_end_0
    .catch Lcom/rokid/utils/exception/ReflectorException; {:try_start_0 .. :try_end_0} :catch_0

    .line 52
    goto :goto_0

    .line 50
    :catch_0
    move-exception v0

    .line 51
    .local v0, "e":Lcom/rokid/utils/exception/ReflectorException;
    invoke-virtual {v0}, Lcom/rokid/utils/exception/ReflectorException;->printStackTrace()V

    .line 54
    .end local v0    # "e":Lcom/rokid/utils/exception/ReflectorException;
    :goto_0
    return-object p0
.end method

.method public bridge synthetic bind(Ljava/lang/Object;)Lcom/rokid/utils/Reflector;
    .locals 0
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/rokid/utils/exception/ReflectorException;
        }
    .end annotation

    .line 14
    invoke-virtual {p0, p1}, Lcom/rokid/utils/QuietReflector;->bind(Ljava/lang/Object;)Lcom/rokid/utils/QuietReflector;

    move-result-object p1

    return-object p1
.end method

.method public field(Ljava/lang/String;)Lcom/rokid/utils/QuietReflector;
    .locals 1
    .param p1, "name"    # Ljava/lang/String;

    .line 59
    iget-object v0, p0, Lcom/rokid/utils/QuietReflector;->mType:Ljava/lang/Class;

    if-nez v0, :cond_0

    .line 60
    return-object p0

    .line 64
    :cond_0
    :try_start_0
    invoke-super {p0, p1}, Lcom/rokid/utils/Reflector;->field(Ljava/lang/String;)Lcom/rokid/utils/Reflector;
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 67
    goto :goto_0

    .line 65
    :catchall_0
    move-exception v0

    .line 66
    .local v0, "e":Ljava/lang/Throwable;
    invoke-virtual {v0}, Ljava/lang/Throwable;->printStackTrace()V

    .line 69
    .end local v0    # "e":Ljava/lang/Throwable;
    :goto_0
    return-object p0
.end method

.method public bridge synthetic field(Ljava/lang/String;)Lcom/rokid/utils/Reflector;
    .locals 0
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/rokid/utils/exception/ReflectorException;
        }
    .end annotation

    .line 14
    invoke-virtual {p0, p1}, Lcom/rokid/utils/QuietReflector;->field(Ljava/lang/String;)Lcom/rokid/utils/QuietReflector;

    move-result-object p1

    return-object p1
.end method

.method public get()Ljava/lang/Object;
    .locals 2
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "<T:",
            "Ljava/lang/Object;",
            ">()TT;"
        }
    .end annotation

    .line 74
    iget-object v0, p0, Lcom/rokid/utils/QuietReflector;->mType:Ljava/lang/Class;

    const/4 v1, 0x0

    if-nez v0, :cond_0

    .line 75
    return-object v1

    .line 78
    :cond_0
    :try_start_0
    invoke-super {p0}, Lcom/rokid/utils/Reflector;->get()Ljava/lang/Object;

    move-result-object v0
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    return-object v0

    .line 79
    :catchall_0
    move-exception v0

    .line 80
    .local v0, "e":Ljava/lang/Throwable;
    invoke-virtual {v0}, Ljava/lang/Throwable;->printStackTrace()V

    .line 83
    .end local v0    # "e":Ljava/lang/Throwable;
    return-object v1
.end method

.method public get(Ljava/lang/Object;)Ljava/lang/Object;
    .locals 2
    .param p1, "caller"    # Ljava/lang/Object;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "<T:",
            "Ljava/lang/Object;",
            ">(",
            "Ljava/lang/Object;",
            ")TT;"
        }
    .end annotation

    .line 88
    iget-object v0, p0, Lcom/rokid/utils/QuietReflector;->mType:Ljava/lang/Class;

    const/4 v1, 0x0

    if-nez v0, :cond_0

    .line 89
    return-object v1

    .line 93
    :cond_0
    :try_start_0
    invoke-super {p0, p1}, Lcom/rokid/utils/Reflector;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    return-object v0

    .line 94
    :catchall_0
    move-exception v0

    .line 95
    .local v0, "e":Ljava/lang/Throwable;
    invoke-virtual {v0}, Ljava/lang/Throwable;->printStackTrace()V

    .line 98
    .end local v0    # "e":Ljava/lang/Throwable;
    return-object v1
.end method

.method public set(Ljava/lang/Object;)Lcom/rokid/utils/QuietReflector;
    .locals 1
    .param p1, "value"    # Ljava/lang/Object;

    .line 102
    iget-object v0, p0, Lcom/rokid/utils/QuietReflector;->mCaller:Ljava/lang/Object;

    invoke-virtual {p0, v0, p1}, Lcom/rokid/utils/QuietReflector;->set(Ljava/lang/Object;Ljava/lang/Object;)Lcom/rokid/utils/QuietReflector;

    move-result-object v0

    return-object v0
.end method

.method public set(Ljava/lang/Object;Ljava/lang/Object;)Lcom/rokid/utils/QuietReflector;
    .locals 1
    .param p1, "caller"    # Ljava/lang/Object;
    .param p2, "value"    # Ljava/lang/Object;

    .line 108
    :try_start_0
    iget-object v0, p0, Lcom/rokid/utils/QuietReflector;->mField:Ljava/lang/reflect/Field;

    invoke-super {p0, p1, v0}, Lcom/rokid/utils/Reflector;->check(Ljava/lang/Object;Ljava/lang/reflect/Member;)V

    .line 109
    iget-object v0, p0, Lcom/rokid/utils/QuietReflector;->mField:Ljava/lang/reflect/Field;

    invoke-virtual {v0, p1, p2}, Ljava/lang/reflect/Field;->set(Ljava/lang/Object;Ljava/lang/Object;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 112
    goto :goto_0

    .line 110
    :catchall_0
    move-exception v0

    .line 111
    .local v0, "e":Ljava/lang/Throwable;
    invoke-virtual {v0}, Ljava/lang/Throwable;->printStackTrace()V

    .line 114
    .end local v0    # "e":Ljava/lang/Throwable;
    :goto_0
    return-object p0
.end method

.method public bridge synthetic set(Ljava/lang/Object;)Lcom/rokid/utils/Reflector;
    .locals 0
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/rokid/utils/exception/ReflectorException;
        }
    .end annotation

    .line 14
    invoke-virtual {p0, p1}, Lcom/rokid/utils/QuietReflector;->set(Ljava/lang/Object;)Lcom/rokid/utils/QuietReflector;

    move-result-object p1

    return-object p1
.end method

.method public bridge synthetic set(Ljava/lang/Object;Ljava/lang/Object;)Lcom/rokid/utils/Reflector;
    .locals 0
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/rokid/utils/exception/ReflectorException;
        }
    .end annotation

    .line 14
    invoke-virtual {p0, p1, p2}, Lcom/rokid/utils/QuietReflector;->set(Ljava/lang/Object;Ljava/lang/Object;)Lcom/rokid/utils/QuietReflector;

    move-result-object p1

    return-object p1
.end method
