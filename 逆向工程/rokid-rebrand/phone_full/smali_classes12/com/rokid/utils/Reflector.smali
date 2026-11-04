.class public Lcom/rokid/utils/Reflector;
.super Ljava/lang/Object;
.source "Reflector.java"


# instance fields
.field protected mCaller:Ljava/lang/Object;

.field protected mConstructor:Ljava/lang/reflect/Constructor;

.field protected mField:Ljava/lang/reflect/Field;

.field protected mMethod:Ljava/lang/reflect/Method;

.field protected mType:Ljava/lang/Class;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/lang/Class<",
            "*>;"
        }
    .end annotation
.end field


# direct methods
.method protected constructor <init>()V
    .locals 0

    .line 30
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 31
    return-void
.end method

.method public static on(Ljava/lang/Class;)Lcom/rokid/utils/Reflector;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/Class<",
            "*>;)",
            "Lcom/rokid/utils/Reflector;"
        }
    .end annotation

    .line 46
    .local p0, "type":Ljava/lang/Class;, "Ljava/lang/Class<*>;"
    new-instance v0, Lcom/rokid/utils/Reflector;

    invoke-direct {v0}, Lcom/rokid/utils/Reflector;-><init>()V

    .line 47
    .local v0, "reflector":Lcom/rokid/utils/Reflector;
    iput-object p0, v0, Lcom/rokid/utils/Reflector;->mType:Ljava/lang/Class;

    .line 48
    return-object v0
.end method

.method public static on(Ljava/lang/String;)Lcom/rokid/utils/Reflector;
    .locals 1
    .param p0, "className"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/rokid/utils/exception/ReflectorException;
        }
    .end annotation

    .line 34
    const-class v0, Lcom/rokid/utils/Reflector;

    invoke-virtual {v0}, Ljava/lang/Class;->getClassLoader()Ljava/lang/ClassLoader;

    move-result-object v0

    invoke-static {p0, v0}, Lcom/rokid/utils/Reflector;->on(Ljava/lang/String;Ljava/lang/ClassLoader;)Lcom/rokid/utils/Reflector;

    move-result-object v0

    return-object v0
.end method

.method public static on(Ljava/lang/String;Ljava/lang/ClassLoader;)Lcom/rokid/utils/Reflector;
    .locals 3
    .param p0, "className"    # Ljava/lang/String;
    .param p1, "loader"    # Ljava/lang/ClassLoader;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/rokid/utils/exception/ReflectorException;
        }
    .end annotation

    .line 39
    const/4 v0, 0x1

    :try_start_0
    invoke-static {p0, v0, p1}, Ljava/lang/Class;->forName(Ljava/lang/String;ZLjava/lang/ClassLoader;)Ljava/lang/Class;

    move-result-object v0

    invoke-static {v0}, Lcom/rokid/utils/Reflector;->on(Ljava/lang/Class;)Lcom/rokid/utils/Reflector;

    move-result-object v0
    :try_end_0
    .catch Ljava/lang/ClassNotFoundException; {:try_start_0 .. :try_end_0} :catch_0

    return-object v0

    .line 40
    :catch_0
    move-exception v0

    .line 41
    .local v0, "e":Ljava/lang/ClassNotFoundException;
    new-instance v1, Lcom/rokid/utils/exception/ReflectorException;

    const-string/jumbo v2, "\u5f00\u4e86\u4e00\u4e2a\u5c0f\u5dee\uff01"

    invoke-direct {v1, v2, v0}, Lcom/rokid/utils/exception/ReflectorException;-><init>(Ljava/lang/String;Ljava/lang/Throwable;)V

    throw v1
.end method

.method public static with(Ljava/lang/Class;)Lcom/rokid/utils/Reflector;
    .locals 3
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/Class<",
            "*>;)",
            "Lcom/rokid/utils/Reflector;"
        }
    .end annotation

    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/rokid/utils/exception/ReflectorException;
        }
    .end annotation

    .line 58
    .local p0, "type":Ljava/lang/Class;, "Ljava/lang/Class<*>;"
    :try_start_0
    invoke-static {p0}, Lcom/rokid/utils/Reflector;->on(Ljava/lang/Class;)Lcom/rokid/utils/Reflector;

    move-result-object v0

    .line 59
    invoke-virtual {p0}, Ljava/lang/Class;->newInstance()Ljava/lang/Object;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/rokid/utils/Reflector;->bind(Ljava/lang/Object;)Lcom/rokid/utils/Reflector;

    move-result-object v0
    :try_end_0
    .catch Lcom/rokid/utils/exception/ReflectorException; {:try_start_0 .. :try_end_0} :catch_2
    .catch Ljava/lang/IllegalAccessException; {:try_start_0 .. :try_end_0} :catch_1
    .catch Ljava/lang/InstantiationException; {:try_start_0 .. :try_end_0} :catch_0

    .line 58
    return-object v0

    .line 60
    :catch_0
    move-exception v0

    goto :goto_0

    :catch_1
    move-exception v0

    goto :goto_0

    :catch_2
    move-exception v0

    .line 61
    .local v0, "e":Ljava/lang/Exception;
    :goto_0
    new-instance v1, Lcom/rokid/utils/exception/ReflectorException;

    const-string/jumbo v2, "\u5f00\u4e86\u4e00\u4e2a\u5c0f\u5dee\uff01"

    invoke-direct {v1, v2, v0}, Lcom/rokid/utils/exception/ReflectorException;-><init>(Ljava/lang/String;Ljava/lang/Throwable;)V

    throw v1
.end method

.method public static with(Ljava/lang/Object;)Lcom/rokid/utils/Reflector;
    .locals 1
    .param p0, "caller"    # Ljava/lang/Object;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/rokid/utils/exception/ReflectorException;
        }
    .end annotation

    .line 52
    invoke-virtual {p0}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v0

    invoke-static {v0}, Lcom/rokid/utils/Reflector;->on(Ljava/lang/Class;)Lcom/rokid/utils/Reflector;

    move-result-object v0

    .line 53
    invoke-virtual {v0, p0}, Lcom/rokid/utils/Reflector;->bind(Ljava/lang/Object;)Lcom/rokid/utils/Reflector;

    move-result-object v0

    .line 52
    return-object v0
.end method


# virtual methods
.method public bind(Ljava/lang/Object;)Lcom/rokid/utils/Reflector;
    .locals 1
    .param p1, "caller"    # Ljava/lang/Object;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/rokid/utils/exception/ReflectorException;
        }
    .end annotation

    .line 66
    invoke-virtual {p0, p1}, Lcom/rokid/utils/Reflector;->checkCaller(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    iput-object v0, p0, Lcom/rokid/utils/Reflector;->mCaller:Ljava/lang/Object;

    .line 67
    return-object p0
.end method

.method public varargs call([Ljava/lang/Object;)Ljava/lang/Object;
    .locals 3
    .param p1, "args"    # [Ljava/lang/Object;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "<T:",
            "Ljava/lang/Object;",
            ">([",
            "Ljava/lang/Object;",
            ")TT;"
        }
    .end annotation

    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/rokid/utils/exception/ReflectorException;
        }
    .end annotation

    .line 130
    :try_start_0
    iget-object v0, p0, Lcom/rokid/utils/Reflector;->mMethod:Ljava/lang/reflect/Method;

    iget-object v1, p0, Lcom/rokid/utils/Reflector;->mCaller:Ljava/lang/Object;

    invoke-virtual {v0, v1, p1}, Ljava/lang/reflect/Method;->invoke(Ljava/lang/Object;[Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0
    :try_end_0
    .catch Ljava/lang/IllegalAccessException; {:try_start_0 .. :try_end_0} :catch_1
    .catch Ljava/lang/reflect/InvocationTargetException; {:try_start_0 .. :try_end_0} :catch_0

    return-object v0

    .line 131
    :catch_0
    move-exception v0

    goto :goto_0

    :catch_1
    move-exception v0

    .line 132
    .local v0, "e":Ljava/lang/ReflectiveOperationException;
    :goto_0
    new-instance v1, Lcom/rokid/utils/exception/ReflectorException;

    const-string/jumbo v2, "\u5f00\u4e86\u4e00\u4e2a\u5c0f\u5dee\uff01"

    invoke-direct {v1, v2, v0}, Lcom/rokid/utils/exception/ReflectorException;-><init>(Ljava/lang/String;Ljava/lang/Throwable;)V

    throw v1
.end method

.method protected check(Ljava/lang/Object;Ljava/lang/reflect/Member;)V
    .locals 2
    .param p1, "caller"    # Ljava/lang/Object;
    .param p2, "member"    # Ljava/lang/reflect/Member;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/rokid/utils/exception/ReflectorException;
        }
    .end annotation

    .line 201
    if-eqz p2, :cond_2

    .line 204
    if-nez p1, :cond_1

    invoke-interface {p2}, Ljava/lang/reflect/Member;->getModifiers()I

    move-result v0

    invoke-static {v0}, Ljava/lang/reflect/Modifier;->isStatic(I)Z

    move-result v0

    if-eqz v0, :cond_0

    goto :goto_0

    .line 205
    :cond_0
    new-instance v0, Lcom/rokid/utils/exception/ReflectorException;

    const-string v1, "The caller is Empty or invalid!"

    invoke-direct {v0, v1}, Lcom/rokid/utils/exception/ReflectorException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 207
    :cond_1
    :goto_0
    invoke-virtual {p0, p1}, Lcom/rokid/utils/Reflector;->checkCaller(Ljava/lang/Object;)Ljava/lang/Object;

    .line 208
    return-void

    .line 202
    :cond_2
    new-instance v0, Lcom/rokid/utils/exception/ReflectorException;

    const-string v1, "The Member is Empty!"

    invoke-direct {v0, v1}, Lcom/rokid/utils/exception/ReflectorException;-><init>(Ljava/lang/String;)V

    throw v0
.end method

.method protected checkCaller(Ljava/lang/Object;)Ljava/lang/Object;
    .locals 3
    .param p1, "caller"    # Ljava/lang/Object;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/rokid/utils/exception/ReflectorException;
        }
    .end annotation

    .line 193
    if-eqz p1, :cond_1

    iget-object v0, p0, Lcom/rokid/utils/Reflector;->mType:Ljava/lang/Class;

    invoke-virtual {v0, p1}, Ljava/lang/Class;->isInstance(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_0

    goto :goto_0

    .line 197
    :cond_0
    new-instance v0, Lcom/rokid/utils/exception/ReflectorException;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "bind failed! caller: "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string/jumbo v2, "type"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    iget-object v2, p0, Lcom/rokid/utils/Reflector;->mType:Ljava/lang/Class;

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-direct {v0, v1}, Lcom/rokid/utils/exception/ReflectorException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 194
    :cond_1
    :goto_0
    return-object p1
.end method

.method public varargs constructor([Ljava/lang/Class;)Lcom/rokid/utils/Reflector;
    .locals 3
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "([",
            "Ljava/lang/Class<",
            "*>;)",
            "Lcom/rokid/utils/Reflector;"
        }
    .end annotation

    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/rokid/utils/exception/ReflectorException;
        }
    .end annotation

    .line 81
    .local p1, "parameterTypes":[Ljava/lang/Class;, "[Ljava/lang/Class<*>;"
    :try_start_0
    iget-object v0, p0, Lcom/rokid/utils/Reflector;->mType:Ljava/lang/Class;

    invoke-virtual {v0, p1}, Ljava/lang/Class;->getDeclaredConstructor([Ljava/lang/Class;)Ljava/lang/reflect/Constructor;

    move-result-object v0

    iput-object v0, p0, Lcom/rokid/utils/Reflector;->mConstructor:Ljava/lang/reflect/Constructor;

    .line 82
    iget-object v0, p0, Lcom/rokid/utils/Reflector;->mConstructor:Ljava/lang/reflect/Constructor;

    const/4 v1, 0x1

    invoke-virtual {v0, v1}, Ljava/lang/reflect/Constructor;->setAccessible(Z)V

    .line 83
    const/4 v0, 0x0

    iput-object v0, p0, Lcom/rokid/utils/Reflector;->mField:Ljava/lang/reflect/Field;

    .line 84
    iput-object v0, p0, Lcom/rokid/utils/Reflector;->mMethod:Ljava/lang/reflect/Method;
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 85
    return-object p0

    .line 86
    :catchall_0
    move-exception v0

    .line 87
    .local v0, "e":Ljava/lang/Throwable;
    new-instance v1, Lcom/rokid/utils/exception/ReflectorException;

    const-string/jumbo v2, "\u5f00\u4e86\u4e00\u4e2a\u5c0f\u5dee\uff01"

    invoke-direct {v1, v2, v0}, Lcom/rokid/utils/exception/ReflectorException;-><init>(Ljava/lang/String;Ljava/lang/Throwable;)V

    throw v1
.end method

.method public field(Ljava/lang/String;)Lcom/rokid/utils/Reflector;
    .locals 3
    .param p1, "name"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/rokid/utils/exception/ReflectorException;
        }
    .end annotation

    .line 138
    :try_start_0
    invoke-virtual {p0, p1}, Lcom/rokid/utils/Reflector;->findField(Ljava/lang/String;)Ljava/lang/reflect/Field;

    move-result-object v0

    iput-object v0, p0, Lcom/rokid/utils/Reflector;->mField:Ljava/lang/reflect/Field;

    .line 139
    iget-object v0, p0, Lcom/rokid/utils/Reflector;->mField:Ljava/lang/reflect/Field;

    const/4 v1, 0x1

    invoke-virtual {v0, v1}, Ljava/lang/reflect/Field;->setAccessible(Z)V

    .line 140
    const/4 v0, 0x0

    iput-object v0, p0, Lcom/rokid/utils/Reflector;->mConstructor:Ljava/lang/reflect/Constructor;

    .line 141
    iput-object v0, p0, Lcom/rokid/utils/Reflector;->mMethod:Ljava/lang/reflect/Method;
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 142
    return-object p0

    .line 143
    :catchall_0
    move-exception v0

    .line 144
    .local v0, "e":Ljava/lang/Throwable;
    new-instance v1, Lcom/rokid/utils/exception/ReflectorException;

    const-string/jumbo v2, "\u5f00\u4e86\u4e00\u4e2a\u5c0f\u5dee\uff01"

    invoke-direct {v1, v2, v0}, Lcom/rokid/utils/exception/ReflectorException;-><init>(Ljava/lang/String;Ljava/lang/Throwable;)V

    throw v1
.end method

.method protected findField(Ljava/lang/String;)Ljava/lang/reflect/Field;
    .locals 3
    .param p1, "name"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/NoSuchFieldException;
        }
    .end annotation

    .line 150
    :try_start_0
    iget-object v0, p0, Lcom/rokid/utils/Reflector;->mType:Ljava/lang/Class;

    invoke-virtual {v0, p1}, Ljava/lang/Class;->getField(Ljava/lang/String;)Ljava/lang/reflect/Field;

    move-result-object v0
    :try_end_0
    .catch Ljava/lang/NoSuchFieldException; {:try_start_0 .. :try_end_0} :catch_0

    return-object v0

    .line 151
    :catch_0
    move-exception v0

    .line 152
    .local v0, "e":Ljava/lang/NoSuchFieldException;
    iget-object v1, p0, Lcom/rokid/utils/Reflector;->mType:Ljava/lang/Class;

    .local v1, "cls":Ljava/lang/Class;, "Ljava/lang/Class<*>;"
    :goto_0
    if-eqz v1, :cond_0

    .line 154
    :try_start_1
    invoke-virtual {v1, p1}, Ljava/lang/Class;->getDeclaredField(Ljava/lang/String;)Ljava/lang/reflect/Field;

    move-result-object v2
    :try_end_1
    .catch Ljava/lang/NoSuchFieldException; {:try_start_1 .. :try_end_1} :catch_1

    return-object v2

    .line 155
    :catch_1
    move-exception v2

    .line 152
    invoke-virtual {v1}, Ljava/lang/Class;->getSuperclass()Ljava/lang/Class;

    move-result-object v1

    goto :goto_0

    .line 159
    .end local v1    # "cls":Ljava/lang/Class;, "Ljava/lang/Class<*>;"
    :cond_0
    throw v0
.end method

.method public get()Ljava/lang/Object;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "<T:",
            "Ljava/lang/Object;",
            ">()TT;"
        }
    .end annotation

    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/rokid/utils/exception/ReflectorException;
        }
    .end annotation

    .line 165
    iget-object v0, p0, Lcom/rokid/utils/Reflector;->mCaller:Ljava/lang/Object;

    invoke-virtual {p0, v0}, Lcom/rokid/utils/Reflector;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    return-object v0
.end method

.method public get(Ljava/lang/Object;)Ljava/lang/Object;
    .locals 3
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

    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/rokid/utils/exception/ReflectorException;
        }
    .end annotation

    .line 170
    iget-object v0, p0, Lcom/rokid/utils/Reflector;->mField:Ljava/lang/reflect/Field;

    invoke-virtual {p0, p1, v0}, Lcom/rokid/utils/Reflector;->check(Ljava/lang/Object;Ljava/lang/reflect/Member;)V

    .line 172
    :try_start_0
    iget-object v0, p0, Lcom/rokid/utils/Reflector;->mField:Ljava/lang/reflect/Field;

    invoke-virtual {v0, p1}, Ljava/lang/reflect/Field;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    return-object v0

    .line 173
    :catchall_0
    move-exception v0

    .line 174
    .local v0, "e":Ljava/lang/Throwable;
    new-instance v1, Lcom/rokid/utils/exception/ReflectorException;

    const-string/jumbo v2, "\u5f00\u4e86\u4e00\u4e2a\u5c0f\u5dee\uff01"

    invoke-direct {v1, v2, v0}, Lcom/rokid/utils/exception/ReflectorException;-><init>(Ljava/lang/String;Ljava/lang/Throwable;)V

    throw v1
.end method

.method public varargs method(Ljava/lang/String;[Ljava/lang/Class;)Lcom/rokid/utils/Reflector;
    .locals 3
    .param p1, "name"    # Ljava/lang/String;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
            "[",
            "Ljava/lang/Class<",
            "*>;)",
            "Lcom/rokid/utils/Reflector;"
        }
    .end annotation

    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/rokid/utils/exception/ReflectorException;
        }
    .end annotation

    .line 107
    .local p2, "parameterTypes":[Ljava/lang/Class;, "[Ljava/lang/Class<*>;"
    :try_start_0
    iget-object v0, p0, Lcom/rokid/utils/Reflector;->mType:Ljava/lang/Class;

    invoke-virtual {v0, p1, p2}, Ljava/lang/Class;->getMethod(Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    move-result-object v0

    iput-object v0, p0, Lcom/rokid/utils/Reflector;->mMethod:Ljava/lang/reflect/Method;
    :try_end_0
    .catch Ljava/lang/NoSuchMethodException; {:try_start_0 .. :try_end_0} :catch_0

    .line 119
    nop

    .line 121
    iget-object v0, p0, Lcom/rokid/utils/Reflector;->mMethod:Ljava/lang/reflect/Method;

    const/4 v1, 0x1

    invoke-virtual {v0, v1}, Ljava/lang/reflect/Method;->setAccessible(Z)V

    .line 122
    const/4 v0, 0x0

    iput-object v0, p0, Lcom/rokid/utils/Reflector;->mConstructor:Ljava/lang/reflect/Constructor;

    .line 123
    iput-object v0, p0, Lcom/rokid/utils/Reflector;->mField:Ljava/lang/reflect/Field;

    .line 124
    return-object p0

    .line 108
    :catch_0
    move-exception v0

    .line 110
    .local v0, "e":Ljava/lang/NoSuchMethodException;
    iget-object v1, p0, Lcom/rokid/utils/Reflector;->mType:Ljava/lang/Class;

    .local v1, "clazz":Ljava/lang/Class;, "Ljava/lang/Class<*>;"
    :goto_0
    if-eqz v1, :cond_0

    .line 112
    :try_start_1
    invoke-virtual {v1, p1, p2}, Ljava/lang/Class;->getDeclaredMethod(Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;
    :try_end_1
    .catch Ljava/lang/NoSuchMethodException; {:try_start_1 .. :try_end_1} :catch_1

    .line 115
    goto :goto_1

    .line 113
    :catch_1
    move-exception v2

    .line 110
    :goto_1
    invoke-virtual {v1}, Ljava/lang/Class;->getSuperclass()Ljava/lang/Class;

    move-result-object v1

    goto :goto_0

    .line 118
    .end local v1    # "clazz":Ljava/lang/Class;, "Ljava/lang/Class<*>;"
    :cond_0
    new-instance v1, Lcom/rokid/utils/exception/ReflectorException;

    const-string/jumbo v2, "\u5f00\u4e86\u4e00\u4e2a\u5c0f\u5dee\uff01"

    invoke-direct {v1, v2, v0}, Lcom/rokid/utils/exception/ReflectorException;-><init>(Ljava/lang/String;Ljava/lang/Throwable;)V

    throw v1
.end method

.method public newInstance()Ljava/lang/Object;
    .locals 3
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "<T:",
            "Ljava/lang/Object;",
            ">()TT;"
        }
    .end annotation

    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/rokid/utils/exception/ReflectorException;
        }
    .end annotation

    .line 73
    :try_start_0
    iget-object v0, p0, Lcom/rokid/utils/Reflector;->mType:Ljava/lang/Class;

    invoke-virtual {v0}, Ljava/lang/Class;->newInstance()Ljava/lang/Object;

    move-result-object v0
    :try_end_0
    .catch Ljava/lang/IllegalAccessException; {:try_start_0 .. :try_end_0} :catch_1
    .catch Ljava/lang/InstantiationException; {:try_start_0 .. :try_end_0} :catch_0

    return-object v0

    .line 74
    :catch_0
    move-exception v0

    goto :goto_0

    :catch_1
    move-exception v0

    .line 75
    .local v0, "e":Ljava/lang/ReflectiveOperationException;
    :goto_0
    new-instance v1, Lcom/rokid/utils/exception/ReflectorException;

    const-string/jumbo v2, "\u5f00\u4e86\u4e00\u4e2a\u5c0f\u5dee\uff01"

    invoke-direct {v1, v2, v0}, Lcom/rokid/utils/exception/ReflectorException;-><init>(Ljava/lang/String;Ljava/lang/Throwable;)V

    throw v1
.end method

.method public varargs newInstance([Ljava/lang/Object;)Ljava/lang/Object;
    .locals 4
    .param p1, "initargs"    # [Ljava/lang/Object;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "<R:",
            "Ljava/lang/Object;",
            ">([",
            "Ljava/lang/Object;",
            ")TR;"
        }
    .end annotation

    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/rokid/utils/exception/ReflectorException;
        }
    .end annotation

    .line 93
    const-string/jumbo v0, "\u5f00\u4e86\u4e00\u4e2a\u5c0f\u5dee\uff01"

    iget-object v1, p0, Lcom/rokid/utils/Reflector;->mConstructor:Ljava/lang/reflect/Constructor;

    if-eqz v1, :cond_0

    .line 97
    :try_start_0
    iget-object v1, p0, Lcom/rokid/utils/Reflector;->mConstructor:Ljava/lang/reflect/Constructor;

    invoke-virtual {v1, p1}, Ljava/lang/reflect/Constructor;->newInstance([Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0
    :try_end_0
    .catch Ljava/lang/reflect/InvocationTargetException; {:try_start_0 .. :try_end_0} :catch_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    return-object v0

    .line 100
    :catchall_0
    move-exception v1

    .line 101
    .local v1, "e":Ljava/lang/Throwable;
    new-instance v2, Lcom/rokid/utils/exception/ReflectorException;

    invoke-direct {v2, v0, v1}, Lcom/rokid/utils/exception/ReflectorException;-><init>(Ljava/lang/String;Ljava/lang/Throwable;)V

    throw v2

    .line 98
    .end local v1    # "e":Ljava/lang/Throwable;
    :catch_0
    move-exception v1

    .line 99
    .local v1, "e":Ljava/lang/reflect/InvocationTargetException;
    new-instance v2, Lcom/rokid/utils/exception/ReflectorException;

    invoke-virtual {v1}, Ljava/lang/reflect/InvocationTargetException;->getTargetException()Ljava/lang/Throwable;

    move-result-object v3

    invoke-direct {v2, v0, v3}, Lcom/rokid/utils/exception/ReflectorException;-><init>(Ljava/lang/String;Ljava/lang/Throwable;)V

    throw v2

    .line 94
    .end local v1    # "e":Ljava/lang/reflect/InvocationTargetException;
    :cond_0
    new-instance v0, Lcom/rokid/utils/exception/ReflectorException;

    const-string v1, "Constructor was null!"

    invoke-direct {v0, v1}, Lcom/rokid/utils/exception/ReflectorException;-><init>(Ljava/lang/String;)V

    throw v0
.end method

.method public set(Ljava/lang/Object;)Lcom/rokid/utils/Reflector;
    .locals 1
    .param p1, "value"    # Ljava/lang/Object;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/rokid/utils/exception/ReflectorException;
        }
    .end annotation

    .line 179
    iget-object v0, p0, Lcom/rokid/utils/Reflector;->mCaller:Ljava/lang/Object;

    invoke-virtual {p0, v0, p1}, Lcom/rokid/utils/Reflector;->set(Ljava/lang/Object;Ljava/lang/Object;)Lcom/rokid/utils/Reflector;

    move-result-object v0

    return-object v0
.end method

.method public set(Ljava/lang/Object;Ljava/lang/Object;)Lcom/rokid/utils/Reflector;
    .locals 3
    .param p1, "caller"    # Ljava/lang/Object;
    .param p2, "value"    # Ljava/lang/Object;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/rokid/utils/exception/ReflectorException;
        }
    .end annotation

    .line 183
    iget-object v0, p0, Lcom/rokid/utils/Reflector;->mField:Ljava/lang/reflect/Field;

    invoke-virtual {p0, p1, v0}, Lcom/rokid/utils/Reflector;->check(Ljava/lang/Object;Ljava/lang/reflect/Member;)V

    .line 185
    :try_start_0
    iget-object v0, p0, Lcom/rokid/utils/Reflector;->mField:Ljava/lang/reflect/Field;

    invoke-virtual {v0, p1, p2}, Ljava/lang/reflect/Field;->set(Ljava/lang/Object;Ljava/lang/Object;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 186
    return-object p0

    .line 187
    :catchall_0
    move-exception v0

    .line 188
    .local v0, "e":Ljava/lang/Throwable;
    new-instance v1, Lcom/rokid/utils/exception/ReflectorException;

    const-string/jumbo v2, "\u5f00\u4e86\u4e00\u4e2a\u5c0f\u5dee\uff01"

    invoke-direct {v1, v2, v0}, Lcom/rokid/utils/exception/ReflectorException;-><init>(Ljava/lang/String;Ljava/lang/Throwable;)V

    throw v1
.end method
