.class final Lcom/rokid/sprite/aiapp/rfmlite/NativeLibrarySupport;
.super Ljava/lang/Object;
.source "NativeLibrarySupport.java"


# static fields
.field private static final ARM64_V8A:Ljava/lang/String; = "arm64-v8a"


# direct methods
.method private constructor <init>()V
    .locals 0

    .line 10
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method static isArm64Process()Z
    .locals 6

    .line 13
    invoke-static {}, Landroid/os/Process;->is64Bit()Z

    move-result v0

    const/4 v1, 0x0

    if-nez v0, :cond_0

    .line 14
    return v1

    .line 17
    :cond_0
    sget-object v0, Landroid/os/Build;->SUPPORTED_ABIS:[Ljava/lang/String;

    array-length v2, v0

    move v3, v1

    :goto_0
    if-ge v3, v2, :cond_2

    aget-object v4, v0, v3

    .line 18
    .local v4, "abi":Ljava/lang/String;
    const-string v5, "arm64-v8a"

    invoke-virtual {v5, v4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v5

    if-eqz v5, :cond_1

    .line 19
    const/4 v0, 0x1

    return v0

    .line 17
    .end local v4    # "abi":Ljava/lang/String;
    :cond_1
    add-int/lit8 v3, v3, 0x1

    goto :goto_0

    .line 22
    :cond_2
    return v1
.end method
