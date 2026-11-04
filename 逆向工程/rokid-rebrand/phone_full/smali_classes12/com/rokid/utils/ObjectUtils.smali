.class public Lcom/rokid/utils/ObjectUtils;
.super Ljava/lang/Object;
.source "ObjectUtils.java"


# direct methods
.method public constructor <init>()V
    .locals 0

    .line 14
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static clone(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;
    .locals 1
    .param p0, "src"    # Ljava/lang/Object;
    .param p1, "dest"    # Ljava/lang/Object;

    .line 19
    :try_start_0
    invoke-static {p0, p1}, Lcom/rokid/utils/ObjectUtils;->copyField(Ljava/lang/Object;Ljava/lang/Object;)V
    :try_end_0
    .catch Ljava/lang/IllegalAccessException; {:try_start_0 .. :try_end_0} :catch_1
    .catch Lcom/rokid/utils/exception/ReflectorException; {:try_start_0 .. :try_end_0} :catch_0

    .line 28
    return-object p1

    .line 31
    :catch_0
    move-exception v0

    .line 32
    .local v0, "e":Lcom/rokid/utils/exception/ReflectorException;
    invoke-virtual {v0}, Lcom/rokid/utils/exception/ReflectorException;->printStackTrace()V

    goto :goto_0

    .line 29
    .end local v0    # "e":Lcom/rokid/utils/exception/ReflectorException;
    :catch_1
    move-exception v0

    .line 30
    .local v0, "e":Ljava/lang/IllegalAccessException;
    invoke-virtual {v0}, Ljava/lang/IllegalAccessException;->printStackTrace()V

    .line 33
    .end local v0    # "e":Ljava/lang/IllegalAccessException;
    nop

    .line 35
    :goto_0
    return-object p1
.end method

.method private static copyField(Ljava/lang/Object;Ljava/lang/Object;)V
    .locals 9
    .param p0, "src"    # Ljava/lang/Object;
    .param p1, "dest"    # Ljava/lang/Object;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/rokid/utils/exception/ReflectorException;,
            Ljava/lang/IllegalAccessException;
        }
    .end annotation

    .line 39
    invoke-virtual {p0}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/Class;->getFields()[Ljava/lang/reflect/Field;

    move-result-object v0

    .line 40
    .local v0, "fields":[Ljava/lang/reflect/Field;
    array-length v1, v0

    const/4 v2, 0x0

    move v3, v2

    :goto_0
    const/4 v4, 0x1

    if-ge v3, v1, :cond_0

    aget-object v5, v0, v3

    .line 41
    .local v5, "field":Ljava/lang/reflect/Field;
    invoke-virtual {v5, v4}, Ljava/lang/reflect/Field;->setAccessible(Z)V

    .line 42
    invoke-virtual {v5}, Ljava/lang/reflect/Field;->getName()Ljava/lang/String;

    move-result-object v4

    .line 43
    .local v4, "name":Ljava/lang/String;
    invoke-static {p1}, Lcom/rokid/utils/Reflector;->with(Ljava/lang/Object;)Lcom/rokid/utils/Reflector;

    move-result-object v6

    invoke-virtual {v6, v4}, Lcom/rokid/utils/Reflector;->field(Ljava/lang/String;)Lcom/rokid/utils/Reflector;

    move-result-object v6

    invoke-virtual {v5, p0}, Ljava/lang/reflect/Field;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v7

    invoke-virtual {v6, v7}, Lcom/rokid/utils/Reflector;->set(Ljava/lang/Object;)Lcom/rokid/utils/Reflector;

    .line 40
    .end local v4    # "name":Ljava/lang/String;
    .end local v5    # "field":Ljava/lang/reflect/Field;
    add-int/lit8 v3, v3, 0x1

    goto :goto_0

    .line 46
    :cond_0
    invoke-virtual {p0}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/Class;->getDeclaredFields()[Ljava/lang/reflect/Field;

    move-result-object v1

    .line 47
    .local v1, "declaredFields":[Ljava/lang/reflect/Field;
    array-length v3, v1

    :goto_1
    if-ge v2, v3, :cond_1

    aget-object v5, v1, v2

    .line 48
    .restart local v5    # "field":Ljava/lang/reflect/Field;
    invoke-virtual {v5, v4}, Ljava/lang/reflect/Field;->setAccessible(Z)V

    .line 49
    invoke-virtual {v5}, Ljava/lang/reflect/Field;->getName()Ljava/lang/String;

    move-result-object v6

    .line 50
    .local v6, "name":Ljava/lang/String;
    invoke-static {p1}, Lcom/rokid/utils/Reflector;->with(Ljava/lang/Object;)Lcom/rokid/utils/Reflector;

    move-result-object v7

    invoke-virtual {v7, v6}, Lcom/rokid/utils/Reflector;->field(Ljava/lang/String;)Lcom/rokid/utils/Reflector;

    move-result-object v7

    invoke-virtual {v5, p0}, Ljava/lang/reflect/Field;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v8

    invoke-virtual {v7, v8}, Lcom/rokid/utils/Reflector;->set(Ljava/lang/Object;)Lcom/rokid/utils/Reflector;

    .line 47
    .end local v5    # "field":Ljava/lang/reflect/Field;
    .end local v6    # "name":Ljava/lang/String;
    add-int/lit8 v2, v2, 0x1

    goto :goto_1

    .line 52
    :cond_1
    return-void
.end method
