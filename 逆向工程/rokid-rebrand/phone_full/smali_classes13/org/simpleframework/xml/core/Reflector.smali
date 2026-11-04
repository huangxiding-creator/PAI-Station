.class final Lorg/simpleframework/xml/core/Reflector;
.super Ljava/lang/Object;
.source "Reflector.java"


# direct methods
.method constructor <init>()V
    .locals 0

    .line 40
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method private static getArrayClass(Ljava/lang/reflect/Type;)Ljava/lang/Class;
    .locals 4
    .param p0, "type"    # Ljava/lang/reflect/Type;

    .line 379
    move-object v0, p0

    check-cast v0, Ljava/lang/reflect/GenericArrayType;

    .line 380
    .local v0, "generic":Ljava/lang/reflect/GenericArrayType;
    invoke-interface {v0}, Ljava/lang/reflect/GenericArrayType;->getGenericComponentType()Ljava/lang/reflect/Type;

    move-result-object v1

    .line 381
    .local v1, "array":Ljava/lang/reflect/Type;
    invoke-static {v1}, Lorg/simpleframework/xml/core/Reflector;->getClass(Ljava/lang/reflect/Type;)Ljava/lang/Class;

    move-result-object v2

    .line 383
    .local v2, "entry":Ljava/lang/Class;
    if-eqz v2, :cond_0

    .line 384
    const/4 v3, 0x0

    invoke-static {v2, v3}, Ljava/lang/reflect/Array;->newInstance(Ljava/lang/Class;I)Ljava/lang/Object;

    move-result-object v3

    invoke-virtual {v3}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v3

    return-object v3

    .line 386
    :cond_0
    const/4 v3, 0x0

    return-object v3
.end method

.method private static getClass(Ljava/lang/reflect/ParameterizedType;)Ljava/lang/Class;
    .locals 2
    .param p0, "type"    # Ljava/lang/reflect/ParameterizedType;

    .line 306
    invoke-interface {p0}, Ljava/lang/reflect/ParameterizedType;->getActualTypeArguments()[Ljava/lang/reflect/Type;

    move-result-object v0

    .line 308
    .local v0, "list":[Ljava/lang/reflect/Type;
    array-length v1, v0

    if-lez v1, :cond_0

    .line 309
    const/4 v1, 0x0

    aget-object v1, v0, v1

    invoke-static {v1}, Lorg/simpleframework/xml/core/Reflector;->getClass(Ljava/lang/reflect/Type;)Ljava/lang/Class;

    move-result-object v1

    return-object v1

    .line 311
    :cond_0
    const/4 v1, 0x0

    return-object v1
.end method

.method private static getClass(Ljava/lang/reflect/Type;)Ljava/lang/Class;
    .locals 1
    .param p0, "type"    # Ljava/lang/reflect/Type;

    .line 345
    instance-of v0, p0, Ljava/lang/Class;

    if-eqz v0, :cond_0

    .line 346
    move-object v0, p0

    check-cast v0, Ljava/lang/Class;

    return-object v0

    .line 348
    :cond_0
    invoke-static {p0}, Lorg/simpleframework/xml/core/Reflector;->getGenericClass(Ljava/lang/reflect/Type;)Ljava/lang/Class;

    move-result-object v0

    return-object v0
.end method

.method private static getClasses(Ljava/lang/reflect/ParameterizedType;)[Ljava/lang/Class;
    .locals 4
    .param p0, "type"    # Ljava/lang/reflect/ParameterizedType;

    .line 325
    invoke-interface {p0}, Ljava/lang/reflect/ParameterizedType;->getActualTypeArguments()[Ljava/lang/reflect/Type;

    move-result-object v0

    .line 326
    .local v0, "list":[Ljava/lang/reflect/Type;
    array-length v1, v0

    new-array v1, v1, [Ljava/lang/Class;

    .line 328
    .local v1, "types":[Ljava/lang/Class;
    const/4 v2, 0x0

    .local v2, "i":I
    :goto_0
    array-length v3, v0

    if-ge v2, v3, :cond_0

    .line 329
    aget-object v3, v0, v2

    invoke-static {v3}, Lorg/simpleframework/xml/core/Reflector;->getClass(Ljava/lang/reflect/Type;)Ljava/lang/Class;

    move-result-object v3

    aput-object v3, v1, v2

    .line 328
    add-int/lit8 v2, v2, 0x1

    goto :goto_0

    .line 331
    .end local v2    # "i":I
    :cond_0
    return-object v1
.end method

.method public static getDependent(Ljava/lang/reflect/Field;)Ljava/lang/Class;
    .locals 2
    .param p0, "field"    # Ljava/lang/reflect/Field;

    .line 54
    invoke-static {p0}, Lorg/simpleframework/xml/core/Reflector;->getType(Ljava/lang/reflect/Field;)Ljava/lang/reflect/ParameterizedType;

    move-result-object v0

    .line 56
    .local v0, "type":Ljava/lang/reflect/ParameterizedType;
    if-eqz v0, :cond_0

    .line 57
    invoke-static {v0}, Lorg/simpleframework/xml/core/Reflector;->getClass(Ljava/lang/reflect/ParameterizedType;)Ljava/lang/Class;

    move-result-object v1

    return-object v1

    .line 59
    :cond_0
    const-class v1, Ljava/lang/Object;

    return-object v1
.end method

.method public static getDependents(Ljava/lang/reflect/Field;)[Ljava/lang/Class;
    .locals 2
    .param p0, "field"    # Ljava/lang/reflect/Field;

    .line 74
    invoke-static {p0}, Lorg/simpleframework/xml/core/Reflector;->getType(Ljava/lang/reflect/Field;)Ljava/lang/reflect/ParameterizedType;

    move-result-object v0

    .line 76
    .local v0, "type":Ljava/lang/reflect/ParameterizedType;
    if-eqz v0, :cond_0

    .line 77
    invoke-static {v0}, Lorg/simpleframework/xml/core/Reflector;->getClasses(Ljava/lang/reflect/ParameterizedType;)[Ljava/lang/Class;

    move-result-object v1

    return-object v1

    .line 79
    :cond_0
    const/4 v1, 0x0

    new-array v1, v1, [Ljava/lang/Class;

    return-object v1
.end method

.method private static getGenericClass(Ljava/lang/reflect/Type;)Ljava/lang/Class;
    .locals 1
    .param p0, "type"    # Ljava/lang/reflect/Type;

    .line 362
    instance-of v0, p0, Ljava/lang/reflect/GenericArrayType;

    if-eqz v0, :cond_0

    .line 363
    invoke-static {p0}, Lorg/simpleframework/xml/core/Reflector;->getArrayClass(Ljava/lang/reflect/Type;)Ljava/lang/Class;

    move-result-object v0

    return-object v0

    .line 365
    :cond_0
    const-class v0, Ljava/lang/Object;

    return-object v0
.end method

.method public static getName(Ljava/lang/String;)Ljava/lang/String;
    .locals 5
    .param p0, "name"    # Ljava/lang/String;

    .line 401
    invoke-virtual {p0}, Ljava/lang/String;->length()I

    move-result v0

    .line 403
    .local v0, "length":I
    if-lez v0, :cond_1

    .line 404
    invoke-virtual {p0}, Ljava/lang/String;->toCharArray()[C

    move-result-object v1

    .line 405
    .local v1, "array":[C
    const/4 v2, 0x0

    aget-char v3, v1, v2

    .line 407
    .local v3, "first":C
    invoke-static {v1}, Lorg/simpleframework/xml/core/Reflector;->isAcronym([C)Z

    move-result v4

    if-nez v4, :cond_0

    .line 408
    invoke-static {v3}, Lorg/simpleframework/xml/core/Reflector;->toLowerCase(C)C

    move-result v4

    aput-char v4, v1, v2

    .line 410
    :cond_0
    new-instance v2, Ljava/lang/String;

    invoke-direct {v2, v1}, Ljava/lang/String;-><init>([C)V

    return-object v2

    .line 412
    .end local v1    # "array":[C
    .end local v3    # "first":C
    :cond_1
    return-object p0
.end method

.method public static getParameterDependent(Ljava/lang/reflect/Constructor;I)Ljava/lang/Class;
    .locals 2
    .param p0, "factory"    # Ljava/lang/reflect/Constructor;
    .param p1, "index"    # I

    .line 217
    invoke-static {p0, p1}, Lorg/simpleframework/xml/core/Reflector;->getParameterType(Ljava/lang/reflect/Constructor;I)Ljava/lang/reflect/ParameterizedType;

    move-result-object v0

    .line 219
    .local v0, "type":Ljava/lang/reflect/ParameterizedType;
    if-eqz v0, :cond_0

    .line 220
    invoke-static {v0}, Lorg/simpleframework/xml/core/Reflector;->getClass(Ljava/lang/reflect/ParameterizedType;)Ljava/lang/Class;

    move-result-object v1

    return-object v1

    .line 222
    :cond_0
    const-class v1, Ljava/lang/Object;

    return-object v1
.end method

.method public static getParameterDependent(Ljava/lang/reflect/Method;I)Ljava/lang/Class;
    .locals 2
    .param p0, "method"    # Ljava/lang/reflect/Method;
    .param p1, "index"    # I

    .line 173
    invoke-static {p0, p1}, Lorg/simpleframework/xml/core/Reflector;->getParameterType(Ljava/lang/reflect/Method;I)Ljava/lang/reflect/ParameterizedType;

    move-result-object v0

    .line 175
    .local v0, "type":Ljava/lang/reflect/ParameterizedType;
    if-eqz v0, :cond_0

    .line 176
    invoke-static {v0}, Lorg/simpleframework/xml/core/Reflector;->getClass(Ljava/lang/reflect/ParameterizedType;)Ljava/lang/Class;

    move-result-object v1

    return-object v1

    .line 178
    :cond_0
    const-class v1, Ljava/lang/Object;

    return-object v1
.end method

.method public static getParameterDependents(Ljava/lang/reflect/Constructor;I)[Ljava/lang/Class;
    .locals 2
    .param p0, "factory"    # Ljava/lang/reflect/Constructor;
    .param p1, "index"    # I

    .line 239
    invoke-static {p0, p1}, Lorg/simpleframework/xml/core/Reflector;->getParameterType(Ljava/lang/reflect/Constructor;I)Ljava/lang/reflect/ParameterizedType;

    move-result-object v0

    .line 241
    .local v0, "type":Ljava/lang/reflect/ParameterizedType;
    if-eqz v0, :cond_0

    .line 242
    invoke-static {v0}, Lorg/simpleframework/xml/core/Reflector;->getClasses(Ljava/lang/reflect/ParameterizedType;)[Ljava/lang/Class;

    move-result-object v1

    return-object v1

    .line 244
    :cond_0
    const/4 v1, 0x0

    new-array v1, v1, [Ljava/lang/Class;

    return-object v1
.end method

.method public static getParameterDependents(Ljava/lang/reflect/Method;I)[Ljava/lang/Class;
    .locals 2
    .param p0, "method"    # Ljava/lang/reflect/Method;
    .param p1, "index"    # I

    .line 195
    invoke-static {p0, p1}, Lorg/simpleframework/xml/core/Reflector;->getParameterType(Ljava/lang/reflect/Method;I)Ljava/lang/reflect/ParameterizedType;

    move-result-object v0

    .line 197
    .local v0, "type":Ljava/lang/reflect/ParameterizedType;
    if-eqz v0, :cond_0

    .line 198
    invoke-static {v0}, Lorg/simpleframework/xml/core/Reflector;->getClasses(Ljava/lang/reflect/ParameterizedType;)[Ljava/lang/Class;

    move-result-object v1

    return-object v1

    .line 200
    :cond_0
    const/4 v1, 0x0

    new-array v1, v1, [Ljava/lang/Class;

    return-object v1
.end method

.method private static getParameterType(Ljava/lang/reflect/Constructor;I)Ljava/lang/reflect/ParameterizedType;
    .locals 3
    .param p0, "factory"    # Ljava/lang/reflect/Constructor;
    .param p1, "index"    # I

    .line 283
    invoke-virtual {p0}, Ljava/lang/reflect/Constructor;->getGenericParameterTypes()[Ljava/lang/reflect/Type;

    move-result-object v0

    .line 285
    .local v0, "list":[Ljava/lang/reflect/Type;
    array-length v1, v0

    if-le v1, p1, :cond_0

    .line 286
    aget-object v1, v0, p1

    .line 288
    .local v1, "type":Ljava/lang/reflect/Type;
    instance-of v2, v1, Ljava/lang/reflect/ParameterizedType;

    if-eqz v2, :cond_0

    .line 289
    move-object v2, v1

    check-cast v2, Ljava/lang/reflect/ParameterizedType;

    return-object v2

    .line 292
    .end local v1    # "type":Ljava/lang/reflect/Type;
    :cond_0
    const/4 v1, 0x0

    return-object v1
.end method

.method private static getParameterType(Ljava/lang/reflect/Method;I)Ljava/lang/reflect/ParameterizedType;
    .locals 3
    .param p0, "method"    # Ljava/lang/reflect/Method;
    .param p1, "index"    # I

    .line 259
    invoke-virtual {p0}, Ljava/lang/reflect/Method;->getGenericParameterTypes()[Ljava/lang/reflect/Type;

    move-result-object v0

    .line 261
    .local v0, "list":[Ljava/lang/reflect/Type;
    array-length v1, v0

    if-le v1, p1, :cond_0

    .line 262
    aget-object v1, v0, p1

    .line 264
    .local v1, "type":Ljava/lang/reflect/Type;
    instance-of v2, v1, Ljava/lang/reflect/ParameterizedType;

    if-eqz v2, :cond_0

    .line 265
    move-object v2, v1

    check-cast v2, Ljava/lang/reflect/ParameterizedType;

    return-object v2

    .line 268
    .end local v1    # "type":Ljava/lang/reflect/Type;
    :cond_0
    const/4 v1, 0x0

    return-object v1
.end method

.method public static getReturnDependent(Ljava/lang/reflect/Method;)Ljava/lang/Class;
    .locals 2
    .param p0, "method"    # Ljava/lang/reflect/Method;

    .line 112
    invoke-static {p0}, Lorg/simpleframework/xml/core/Reflector;->getReturnType(Ljava/lang/reflect/Method;)Ljava/lang/reflect/ParameterizedType;

    move-result-object v0

    .line 114
    .local v0, "type":Ljava/lang/reflect/ParameterizedType;
    if-eqz v0, :cond_0

    .line 115
    invoke-static {v0}, Lorg/simpleframework/xml/core/Reflector;->getClass(Ljava/lang/reflect/ParameterizedType;)Ljava/lang/Class;

    move-result-object v1

    return-object v1

    .line 117
    :cond_0
    const-class v1, Ljava/lang/Object;

    return-object v1
.end method

.method public static getReturnDependents(Ljava/lang/reflect/Method;)[Ljava/lang/Class;
    .locals 2
    .param p0, "method"    # Ljava/lang/reflect/Method;

    .line 132
    invoke-static {p0}, Lorg/simpleframework/xml/core/Reflector;->getReturnType(Ljava/lang/reflect/Method;)Ljava/lang/reflect/ParameterizedType;

    move-result-object v0

    .line 134
    .local v0, "type":Ljava/lang/reflect/ParameterizedType;
    if-eqz v0, :cond_0

    .line 135
    invoke-static {v0}, Lorg/simpleframework/xml/core/Reflector;->getClasses(Ljava/lang/reflect/ParameterizedType;)[Ljava/lang/Class;

    move-result-object v1

    return-object v1

    .line 137
    :cond_0
    const/4 v1, 0x0

    new-array v1, v1, [Ljava/lang/Class;

    return-object v1
.end method

.method private static getReturnType(Ljava/lang/reflect/Method;)Ljava/lang/reflect/ParameterizedType;
    .locals 2
    .param p0, "method"    # Ljava/lang/reflect/Method;

    .line 151
    invoke-virtual {p0}, Ljava/lang/reflect/Method;->getGenericReturnType()Ljava/lang/reflect/Type;

    move-result-object v0

    .line 153
    .local v0, "type":Ljava/lang/reflect/Type;
    instance-of v1, v0, Ljava/lang/reflect/ParameterizedType;

    if-eqz v1, :cond_0

    .line 154
    move-object v1, v0

    check-cast v1, Ljava/lang/reflect/ParameterizedType;

    return-object v1

    .line 156
    :cond_0
    const/4 v1, 0x0

    return-object v1
.end method

.method private static getType(Ljava/lang/reflect/Field;)Ljava/lang/reflect/ParameterizedType;
    .locals 2
    .param p0, "field"    # Ljava/lang/reflect/Field;

    .line 92
    invoke-virtual {p0}, Ljava/lang/reflect/Field;->getGenericType()Ljava/lang/reflect/Type;

    move-result-object v0

    .line 94
    .local v0, "type":Ljava/lang/reflect/Type;
    instance-of v1, v0, Ljava/lang/reflect/ParameterizedType;

    if-eqz v1, :cond_0

    .line 95
    move-object v1, v0

    check-cast v1, Ljava/lang/reflect/ParameterizedType;

    return-object v1

    .line 97
    :cond_0
    const/4 v1, 0x0

    return-object v1
.end method

.method private static isAcronym([C)Z
    .locals 3
    .param p0, "array"    # [C

    .line 425
    array-length v0, p0

    const/4 v1, 0x2

    const/4 v2, 0x0

    if-ge v0, v1, :cond_0

    .line 426
    return v2

    .line 428
    :cond_0
    aget-char v0, p0, v2

    invoke-static {v0}, Lorg/simpleframework/xml/core/Reflector;->isUpperCase(C)Z

    move-result v0

    if-nez v0, :cond_1

    .line 429
    return v2

    .line 431
    :cond_1
    const/4 v0, 0x1

    aget-char v0, p0, v0

    invoke-static {v0}, Lorg/simpleframework/xml/core/Reflector;->isUpperCase(C)Z

    move-result v0

    return v0
.end method

.method private static isUpperCase(C)Z
    .locals 1
    .param p0, "value"    # C

    .line 455
    invoke-static {p0}, Ljava/lang/Character;->isUpperCase(C)Z

    move-result v0

    return v0
.end method

.method private static toLowerCase(C)C
    .locals 1
    .param p0, "value"    # C

    .line 443
    invoke-static {p0}, Ljava/lang/Character;->toLowerCase(C)C

    move-result v0

    return v0
.end method
