.class public Lorg/apache/commons/compress/utils/OsgiUtils;
.super Ljava/lang/Object;
.source "OsgiUtils.java"


# static fields
.field private static final inOsgiEnvironment:Z


# direct methods
.method static constructor <clinit>()V
    .locals 2

    .line 31
    const-class v0, Lorg/apache/commons/compress/utils/OsgiUtils;

    invoke-virtual {v0}, Ljava/lang/Class;->getClassLoader()Ljava/lang/ClassLoader;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v0

    .line 32
    .local v0, "classloaderClass":Ljava/lang/Class;, "Ljava/lang/Class<*>;"
    invoke-static {v0}, Lorg/apache/commons/compress/utils/OsgiUtils;->isBundleReference(Ljava/lang/Class;)Z

    move-result v1

    sput-boolean v1, Lorg/apache/commons/compress/utils/OsgiUtils;->inOsgiEnvironment:Z

    .line 33
    .end local v0    # "classloaderClass":Ljava/lang/Class;, "Ljava/lang/Class<*>;"
    return-void
.end method

.method public constructor <init>()V
    .locals 0

    .line 26
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method private static isBundleReference(Ljava/lang/Class;)Z
    .locals 7
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/Class<",
            "*>;)Z"
        }
    .end annotation

    .line 36
    .local p0, "clazz":Ljava/lang/Class;, "Ljava/lang/Class<*>;"
    move-object v0, p0

    .line 37
    .local v0, "c":Ljava/lang/Class;, "Ljava/lang/Class<*>;"
    :goto_0
    const/4 v1, 0x0

    if-eqz v0, :cond_3

    .line 38
    invoke-virtual {v0}, Ljava/lang/Class;->getName()Ljava/lang/String;

    move-result-object v2

    const-string v3, "org.osgi.framework.BundleReference"

    invoke-virtual {v2, v3}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    const/4 v3, 0x1

    if-eqz v2, :cond_0

    .line 39
    return v3

    .line 41
    :cond_0
    invoke-virtual {v0}, Ljava/lang/Class;->getInterfaces()[Ljava/lang/Class;

    move-result-object v2

    array-length v4, v2

    :goto_1
    if-ge v1, v4, :cond_2

    aget-object v5, v2, v1

    .line 42
    .local v5, "ifc":Ljava/lang/Class;, "Ljava/lang/Class<*>;"
    invoke-static {v5}, Lorg/apache/commons/compress/utils/OsgiUtils;->isBundleReference(Ljava/lang/Class;)Z

    move-result v6

    if-eqz v6, :cond_1

    .line 43
    return v3

    .line 41
    .end local v5    # "ifc":Ljava/lang/Class;, "Ljava/lang/Class<*>;"
    :cond_1
    add-int/lit8 v1, v1, 0x1

    goto :goto_1

    .line 46
    :cond_2
    invoke-virtual {v0}, Ljava/lang/Class;->getSuperclass()Ljava/lang/Class;

    move-result-object v0

    goto :goto_0

    .line 48
    :cond_3
    return v1
.end method

.method public static isRunningInOsgiEnvironment()Z
    .locals 1

    .line 56
    sget-boolean v0, Lorg/apache/commons/compress/utils/OsgiUtils;->inOsgiEnvironment:Z

    return v0
.end method
