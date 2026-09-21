package ir.hhm.fdweb

import android.webkit.WebResourceResponse
import java.io.ByteArrayInputStream

object AdBlocker {

    private val blockedDomains = setOf(
        "doubleclick.net",
        "googlesyndication.com",
        "googleadservices.com",
        "google-analytics.com",
        "googletagmanager.com",
        "googletagservices.com",
        "adservice.google.com",
        "pagead2.googlesyndication.com",
        "adclick.g.doubleclick.net",
        "partner.googleadservices.com",
        "amazon-adsystem.com",
        "adnxs.com",
        "adsrvr.org",
        "criteo.com",
        "criteo.net",
        "outbrain.com",
        "taboola.com",
        "scorecardresearch.com",
        "quantserve.com",
        "pubmatic.com",
        "rubiconproject.com",
        "openx.net",
        "casalemedia.com",
        "indexexchange.com",
        "sharethrough.com",
        "teads.tv",
        "smartadserver.com",
        "advertising.com",
        "bidswitch.net",
        "sitescout.com",
        "turn.com",
        "mathtag.com",
        "tremorhub.com",
        "spotxchange.com",
        "yieldmo.com",
        "gumgum.com",
        "sovrn.com",
        "lijit.com",
        "hotjar.com",
        "mixpanel.com",
        "segment.com",
        "segment.io",
        "amplitude.com",
        "newrelic.com",
        "nr-data.net",
        "sentry.io",
        "bugsnag.com",
        "raygun.io",
        "mouseflow.com",
        "crazyegg.com",
        "fullstory.com",
        "inspectlet.com",
        "luckyorange.com",
        "connect.facebook.net",
        "analytics.twitter.com",
        "ads.linkedin.com",
        "platform.linkedin.com",
        "bat.bing.com",
        "ads.pinterest.com",
        "ct.pinterest.com",
        "yektanet.com",
        "cdn.yektanet.com",
        "an.yandex.ru",
        "mc.yandex.ru",
        "yadro.com",
        "clickyab.com",
        "tapsell.ir",
        "sabavision.com",
        "mediaad.org",
        "adad.ir",
        "goon.ir",
        "mihanads.com",
        "sanjagh.pro",
        "sanjagh.com",
        "adtrace.org",
        "adcolony.com",
        "applovin.com",
        "unityads.unity3d.com",
        "vungle.com",
        "chartboost.com",
        "inmobi.com",
        "mopub.com",
        "startapp.com",
        "supersonicads.com",
        "flurry.com",
        "adjust.com",
        "appsflyer.com",
        "branch.io",
        "kochava.com",
        "onesignal.com"
    )

    private val blockedPrefixes = setOf(
        "ad.", "ads.", "advert.", "advertising.",
        "banner.", "click.", "track.", "tracker.",
        "analytics.", "stats.", "stat.", "pixel.", "beacon."
    )

    private val emptyResponse = ByteArray(0)

    fun shouldBlock(url: String): Boolean {
        if (url.isBlank()) return false
        val lower = url.lowercase()

        for (domain in blockedDomains) {
            if (lower.contains(domain)) return true
        }

        try {
            val host = url.substringAfter("://").substringBefore("/").substringBefore(":")
            for (prefix in blockedPrefixes) {
                if (host.startsWith(prefix)) return true
            }
        } catch (_: Exception) { }

        return false
    }

    fun getEmptyResponse(): WebResourceResponse {
        return WebResourceResponse(
            "text/plain",
            "utf-8",
            200,
            "OK",
            emptyMap(),
            ByteArrayInputStream(emptyResponse)
        )
    }
}
