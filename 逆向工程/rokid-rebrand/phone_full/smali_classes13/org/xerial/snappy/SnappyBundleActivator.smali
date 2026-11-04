.class public Lorg/xerial/snappy/SnappyBundleActivator;
.super Ljava/lang/Object;
.source "SnappyBundleActivator.java"

# interfaces
.implements Lorg/osgi/framework/BundleActivator;


# static fields
.field public static final LIBRARY_NAME:Ljava/lang/String; = "snappyjava"


# direct methods
.method public constructor <init>()V
    .locals 0

    .line 38
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public start(Lorg/osgi/framework/BundleContext;)V
    .locals 2
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/Exception;
        }
    .end annotation

    .line 53
    const-string p1, "snappyjava"

    invoke-static {p1}, Ljava/lang/System;->mapLibraryName(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p1

    .line 54
    invoke-virtual {p1}, Ljava/lang/String;->toLowerCase()Ljava/lang/String;

    move-result-object v0

    const-string v1, ".dylib"

    invoke-virtual {v0, v1}, Ljava/lang/String;->endsWith(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_0

    .line 56
    const-string v0, ".jnilib"

    invoke-virtual {p1, v1, v0}, Ljava/lang/String;->replace(Ljava/lang/CharSequence;Ljava/lang/CharSequence;)Ljava/lang/String;

    move-result-object p1

    .line 58
    :cond_0
    invoke-static {p1}, Ljava/lang/System;->loadLibrary(Ljava/lang/String;)V

    .line 59
    new-instance p1, Lorg/xerial/snappy/SnappyNative;

    invoke-direct {p1}, Lorg/xerial/snappy/SnappyNative;-><init>()V

    invoke-static {p1}, Lorg/xerial/snappy/SnappyLoader;->setSnappyApi(Lorg/xerial/snappy/SnappyNative;)V

    .line 60
    return-void
.end method

.method public stop(Lorg/osgi/framework/BundleContext;)V
    .locals 0
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/Exception;
        }
    .end annotation

    .line 65
    const/4 p1, 0x0

    invoke-static {p1}, Lorg/xerial/snappy/SnappyLoader;->setSnappyApi(Lorg/xerial/snappy/SnappyNative;)V

    .line 66
    invoke-static {}, Lorg/xerial/snappy/SnappyLoader;->cleanUpExtractedNativeLib()V

    .line 67
    return-void
.end method
